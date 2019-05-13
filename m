Return-Path: <SRS0=K8Ai=TN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2407C04AB1
	for <rcu@archiver.kernel.org>; Mon, 13 May 2019 03:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0E920862
	for <rcu@archiver.kernel.org>; Mon, 13 May 2019 03:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="osIpkuHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfEMDaV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 12 May 2019 23:30:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45604 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfEMDaU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 12 May 2019 23:30:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id a5so5702012pls.12
        for <rcu@vger.kernel.org>; Sun, 12 May 2019 20:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8x/JEW89CcQQFFcT0Io3jWhU+91YL3+GS6eo7Tv33r0=;
        b=osIpkuHNx7w1UmaWcTbGreqOp20fS9h/kiCPJT0yZ/a2LXx7byZ/mS/GNN+zOPidq+
         Y5UAX09lcUHK+kxUUhtE5q+Sjco4y6lgQ02QVUdg6xohWDHPx/WcmOsPLvBNobEwppku
         JubCuzX3OMORdWgcAHCtX9h985w8f/0J0wgdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8x/JEW89CcQQFFcT0Io3jWhU+91YL3+GS6eo7Tv33r0=;
        b=BrBjRXPNenGXqJliJh2h21zmtdeTFNdEfTjmdQ7lNJRANc9ayB2jDGatozN1KbQALI
         dnNQ/FBDkGnJTItC3R6iQvmwU/2ipsQw+CBcHFiB9mnOqXlbiIWO5nye+9lfKS/+23jQ
         9BdiC7JRkud+cm6owA+oBGky+lWjJyr9s5O0WqpbQ8B/whiUTbjdQOI9RnYAnBxiuqF5
         N1QWWn81IEjgwY3VdMNEJr7ggh5IVjGi/jE2S9KrcD45NEgrGKa71MoZz5DlPuhY47CH
         Y62TFmB7SxqGOrm1KetveZpUgh6K0tJKaXHvqxCj5egsa6z+/BmMyEzJq4Y2Y4HwKRuj
         NFig==
X-Gm-Message-State: APjAAAWQJeb7c1oZ5Qdzs8sEwNCO5HoGAih9LP2LFpDfwQzQCTe3JEnr
        7AA7QWoartwnb3/s2oRE8oa8+g==
X-Google-Smtp-Source: APXvYqzSobamq/EhqyuwlW4ZoNK/NhBMxdFwaT7FbUKNpv6F41fMyCiWPaurUs3C1DWy7oqsu1APog==
X-Received: by 2002:a17:902:2883:: with SMTP id f3mr2458139plb.26.1557718219708;
        Sun, 12 May 2019 20:30:19 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p63sm13927902pfb.70.2019.05.12.20.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 20:30:18 -0700 (PDT)
Date:   Sun, 12 May 2019 23:30:17 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org
Subject: Re: Should list_entry_rcu use rcu_dereference ?
Message-ID: <20190513033017.GA96252@google.com>
References: <20190504185944.GA79652@google.com>
 <20190506235430.GA3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506235430.GA3923@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Mon, May 06, 2019 at 04:54:30PM -0700, Paul E. McKenney wrote:
> > Looking at the list_entry_rcu primitive, I see it does direct READ_ONCE
> > on ptr. That's Ok, but rcu_dereference also does additional lockdep and
> > sparse checking.  Why not call rcu_dereference instead of READ_ONCE? The
> > pointer may be dereference by the caller so IMO makes sense to check.
> > 
> > Here is the definition of list_entry_rcu:
> > /**
> >  * list_entry_rcu - get the struct for this entry
> >  [snip]
> > * This primitive may safely run concurrently with the _rcu list-mutation
> >  * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
> >  */
> > #define list_entry_rcu(ptr, type, member) \
> > 	container_of(READ_ONCE(ptr), type, member)
> > 
> > Also, I was curious why hlist_for_each_entry_rcu() uses rcu_dereference_raw()
> > while __hlist_for_each_rcu)_ uses rcu_dereference(). I feel both should use
> > rcu_dereference to have the lockdep checking. Is this not done due to
> > performance reasons?
> > 
> > thanks!
> > 
> >   - Joel
> 
> The issue is that most of the RCU list macros are generic over the RCU
> read-side flavors.  We could have created _bh and _sched variants of all
> of these, but that seemed like way too much RCU API expansion at the time,
> and still does.  This shows up in the sparse checking as well, so that
> there is just __rcu instead of also being __rcu_bh and __rcu_sched.
> 
> Or are do you have a trick in mind that would allow lockdep checking
> without RCU API expansion?

Sorry it took me a while to reply, I had it in mind to reply and was thinking
about how to do it.

How about something like the following? It does cause some API expansion,
however just one function: rcu_dereference_any(). The purpose of this is to
check if any RCU reader is active at all. I believe after the flavor
consolidation effort, this is a sufficient condition from an RCU perspective.
Having some lockdep checking is better than no lockdep checking so I think it
is good to have. Let me know what you think about the below patch and I can
roll into a proper patch and send it as well (with proper comments).

I was able to trigger the lockdep check by removing the preempt_disable()
calls in ftrace_mod_get_kallsym() and insert some modules (PROVE_LOCKING and
FUNCION_TRACE enabled).

---8<-----------------------

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index e91ec9ddcd30..334c625ef421 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -273,9 +273,12 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  *
  * This primitive may safely run concurrently with the _rcu list-mutation
  * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
+ *
+ * Use rcu_dereference_any() to ensure we are generically within an RCU reader
+ * section (whether sched, bh or regular).
  */
 #define list_entry_rcu(ptr, type, member) \
-	container_of(READ_ONCE(ptr), type, member)
+	container_of(rcu_dereference_any(ptr), type, member)
 
 /*
  * Where are list_empty_rcu() and list_first_entry_rcu()?
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 922bb6848813..7481d93ed9bb 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -223,6 +223,7 @@ int debug_lockdep_rcu_enabled(void);
 int rcu_read_lock_held(void);
 int rcu_read_lock_bh_held(void);
 int rcu_read_lock_sched_held(void);
+int rcu_read_lock_any_held(void);
 
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
@@ -243,6 +244,12 @@ static inline int rcu_read_lock_sched_held(void)
 {
 	return !preemptible();
 }
+
+static inline int rcu_read_lock_any_held(void)
+{
+	return !preemptible();
+}
+
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 #ifdef CONFIG_PROVE_RCU
@@ -472,6 +479,10 @@ static inline void rcu_preempt_sleep_check(void) { }
 	__rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
 				__rcu)
 
+#define rcu_dereference_any_check(p, c) \
+	__rcu_dereference_check((p), (c) || rcu_read_lock_any_held(), \
+				__rcu)
+
 /*
  * The tracing infrastructure traces RCU (we want that), but unfortunately
  * some of the RCU checks causes tracing to lock up the system.
@@ -525,6 +536,8 @@ static inline void rcu_preempt_sleep_check(void) { }
  */
 #define rcu_dereference_sched(p) rcu_dereference_sched_check(p, 0)
 
+#define rcu_dereference_any(p) rcu_dereference_any_check(p, 0)
+
 /**
  * rcu_pointer_handoff() - Hand off a pointer from RCU to other mechanism
  * @p: The pointer to hand off
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c3bf44ba42e5..2dab75d34806 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -298,6 +298,31 @@ int rcu_read_lock_bh_held(void)
 }
 EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
 
+int rcu_read_lock_any_held(void)
+{
+	int lockdep_opinion = 0;
+
+	if (!debug_lockdep_rcu_enabled())
+		return 1;
+	if (!rcu_is_watching())
+		return 0;
+	if (!rcu_lockdep_current_cpu_online())
+		return 0;
+
+	if (lock_is_held(&rcu_lock_map))
+		return 1;
+
+	/* BH flavor */
+	if (in_softirq() || irqs_disabled())
+		return 1;
+
+	/* Sched flavor */
+	if (debug_locks)
+		lockdep_opinion = lock_is_held(&rcu_sched_lock_map);
+	return lockdep_opinion || !preemptible();
+}
+EXPORT_SYMBOL_GPL(rcu_read_lock_any_held);
+
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 /**
-- 
2.21.0.1020.gf2820cf01a-goog

