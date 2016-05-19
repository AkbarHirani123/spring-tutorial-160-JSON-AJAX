package com.caveofprogramming.spring.web.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
@Component("messsagesDao")
public class MessagesDao {

	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}

	@SuppressWarnings("unchecked")
	public List<Message> getMessages() {
		Criteria crit = session().createCriteria(Message.class);
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<Message> getMessages(String username) {

		Criteria crit = session().createCriteria(Message.class);
		crit.add(Restrictions.eq("username", username));

		return crit.list();
	}

	// Refactored method
	public void saveOrUpdate(Message message) {
		System.out.println(message);
		session().saveOrUpdate(message);
	}

	public boolean delete(int id) {
		Query query = session().createQuery("delete from Message where id=:id");
		query.setLong("id", id);
		return query.executeUpdate() == 1;
	}

	public Message getMessage(int id) {

		Criteria crit = session().createCriteria(Message.class);
		crit.add(Restrictions.idEq(id));

		return (Message) crit.uniqueResult();

	}

	// This method is not being used but the way to change to hibernate is:
	// search for hibernate batch
	// use the same session().save() method we used in create
	// use it in a loop
	// set a property that checks the jdbc batch update size
	// also need to flush the session after a few inserts.

	// @Transactional
	// public int[] create(List<Offer> offers) {
	//
	// SqlParameterSource[] params = SqlParameterSourceUtils
	// .createBatch(offers.toArray());
	//
	// return jdbc.batchUpdate(
	// "insert into offer (text, username) values (:text, :username)",
	// params);
	// }

	// REPLACED BOTH OF THESE METHODS TO REFACTOR AS "saveOrUpdate" BELOW
	// public void update(Offer offer) {
	// session().update(offer);
	// }
	//
	// public void create(Offer offer) {
	//
	// session().save(offer);
	// }

}
