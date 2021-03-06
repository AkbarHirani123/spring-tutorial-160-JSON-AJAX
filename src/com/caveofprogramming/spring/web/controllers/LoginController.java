package com.caveofprogramming.spring.web.controllers;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.caveofprogramming.spring.web.dao.FormValidationGroup;
import com.caveofprogramming.spring.web.dao.Message;
import com.caveofprogramming.spring.web.dao.User;
import com.caveofprogramming.spring.web.service.UsersService;

@Controller
public class LoginController {

	private UsersService usersService;

	@Autowired
	public void setOffersService(UsersService usersService) {
		this.usersService = usersService;
	}

	@RequestMapping("/login")
	public String showLogin() {
		return "login";
	}

	@RequestMapping("/admin")
	public String showAdmin(Model model) {

		List<User> users = usersService.getAllUsers();

		model.addAttribute("users", users);

		return "admin";
	}

	@RequestMapping("/loggedout")
	public String showLoggedOut() {
		return "loggedout";
	}

	@RequestMapping("/denied")
	public String showDenied() {
		return "denied";
	}

	@RequestMapping("/newaccount")
	public String showNewAccount(Model model) {

		model.addAttribute("user", new User());
		return "newaccount";
	}

	@RequestMapping(value = "/createaccount", method = RequestMethod.POST)
	public String createAccount(
			@Validated(FormValidationGroup.class) User user,
			BindingResult result) {

		if (result.hasErrors()) {
			return "newaccount";
		}

		user.setEnabled(true);
		user.setAuthority("ROLE_USER");

		if (usersService.exists(user.getUsername())) {
			result.rejectValue("username", "DuplicateKey.user.username");
			return "newaccount";
		}
		try {
			usersService.create(user);
		} catch (DuplicateKeyException e) {

			result.rejectValue("username", "DuplicateKey.user.username",
					"This username already exists!");
			return "newaccount";
		}

		return "accountcreated";
	}

	@RequestMapping(value = "/getmessages", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public Map<String, Object> getMessages(Principal principal) {

		List<Message> messages = null;
		if (principal == null) {
			messages = new ArrayList<Message>();
		} else {
			String username = principal.getName();
			messages = usersService.getMessages(username);
		}
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("messages", messages);
		data.put("number", messages.size());

		return data;
	}

	@RequestMapping("/messages")
	public String showMessages() {
		return "messages";
	}

	@RequestMapping(value = "/sendmessage", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Map<String, Object> sendMessage(Principal principal,
			@RequestBody Map<String, Object> data) {

		String text = (String) data.get("text");
		String name = (String) data.get("name");
		String email = (String) data.get("email");
		Integer target = (Integer) data.get("target");

		System.out.println(name + " : " + email + " : " + text);

		Map<String, Object> rval = new HashMap<String, Object>();

		rval.put("success", true);
		rval.put("target", target);

		return rval;
	}
}
