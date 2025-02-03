Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634301FF1D7
	for <rcu@vger.kernel.org>; Mon,  3 Feb 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738574972; cv=none; b=XgEvr/JXKlW/gQvNhsjxzmGoxz0A4vNMJeHFgQ42FLNz47IN7PBwd3OuphsJY1qfU2cT0/A1FaW9X+QD2XRv6AhMQWK6ygRP9mGf3Wym5dDFkmBQXlCoXsFQNfN28Hjj6IIeKMgjvDRnd1E+0AwGyuHcGuIVm7EBLsEYmShBoEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738574972; c=relaxed/simple;
	bh=X7hKG/Z8YcJcnrzfyVDDXyZTn7CP4HsNw7N1yazCglk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s7ZGR7UO8ifyRYqsz/exkxy6eeQieS2ZbgdxrAZJvqG38vpP7dCpGvQQLc7SEIELWU0SiD67sFKmmEdqGK5cX1EG3JrTSYwZsalLSHyeS+9zInF24SvWkgOY6TmafDdl9u5yeFwH+wIrmi7nlGVpZjs2CaYAcKWNUWBGBIFVEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 98FFC21137;
	Mon,  3 Feb 2025 09:29:28 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78FEC13A96;
	Mon,  3 Feb 2025 09:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ALNDHXiMoGfwYAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 03 Feb 2025 09:29:28 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 03 Feb 2025 10:28:48 +0100
Subject: [PATCH 2/4] rcu: remove trace_rcu_kvfree_callback
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-slub-tiny-kfree_rcu-v1-2-d4428bf9a8a1@suse.cz>
References: <20250203-slub-tiny-kfree_rcu-v1-0-d4428bf9a8a1@suse.cz>
In-Reply-To: <20250203-slub-tiny-kfree_rcu-v1-0-d4428bf9a8a1@suse.cz>
To: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Joel Fernandes <joel@joelfernandes.org>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
 rcu@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 98FFC21137
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Tree RCU does not handle kvfree_rcu() by queueing individual objects by
call_rcu() anymore, thus the tracepoint and associated
__is_kvfree_rcu_offset() check is dead code now. Remove it.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/trace/events/rcu.h | 34 ----------------------------------
 kernel/rcu/tree.c          |  9 ++-------
 2 files changed, 2 insertions(+), 41 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index e81431deaa50b21725b08ad7c1a2992a0074065a..ac3b28b8939b78843aecb44bed8cb76c451ab060 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -560,40 +560,6 @@ TRACE_EVENT_RCU(rcu_segcb_stats,
 
 );
 
-/*
- * Tracepoint for the registration of a single RCU callback of the special
- * kvfree() form.  The first argument is the RCU type, the second argument
- * is a pointer to the RCU callback, the third argument is the offset
- * of the callback within the enclosing RCU-protected data structure,
- * the fourth argument is the number of lazy callbacks queued, and the
- * fifth argument is the total number of callbacks queued.
- */
-TRACE_EVENT_RCU(rcu_kvfree_callback,
-
-	TP_PROTO(const char *rcuname, struct rcu_head *rhp, unsigned long offset,
-		 long qlen),
-
-	TP_ARGS(rcuname, rhp, offset, qlen),
-
-	TP_STRUCT__entry(
-		__field(const char *, rcuname)
-		__field(void *, rhp)
-		__field(unsigned long, offset)
-		__field(long, qlen)
-	),
-
-	TP_fast_assign(
-		__entry->rcuname = rcuname;
-		__entry->rhp = rhp;
-		__entry->offset = offset;
-		__entry->qlen = qlen;
-	),
-
-	TP_printk("%s rhp=%p func=%ld %ld",
-		  __entry->rcuname, __entry->rhp, __entry->offset,
-		  __entry->qlen)
-);
-
 /*
  * Tracepoint for marking the beginning rcu_do_batch, performed to start
  * RCU callback invocation.  The first argument is the RCU flavor,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 475f31deed1418d73d097bb4d39fe714814fefa3..5dbc4189037c501b8c671598131ed5ea6d4afd71 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2931,13 +2931,8 @@ static int __init rcu_spawn_core_kthreads(void)
 static void rcutree_enqueue(struct rcu_data *rdp, struct rcu_head *head, rcu_callback_t func)
 {
 	rcu_segcblist_enqueue(&rdp->cblist, head);
-	if (__is_kvfree_rcu_offset((unsigned long)func))
-		trace_rcu_kvfree_callback(rcu_state.name, head,
-					 (unsigned long)func,
-					 rcu_segcblist_n_cbs(&rdp->cblist));
-	else
-		trace_rcu_callback(rcu_state.name, head,
-				   rcu_segcblist_n_cbs(&rdp->cblist));
+	trace_rcu_callback(rcu_state.name, head,
+			   rcu_segcblist_n_cbs(&rdp->cblist));
 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
 }
 

-- 
2.48.1

