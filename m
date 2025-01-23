Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A2220D4E5
	for <rcu@vger.kernel.org>; Thu, 23 Jan 2025 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628680; cv=none; b=MTBE6gHAraM48pTlgnwEZUEVJwJac2R6Da53ODoK5IhlTsNxLzVhHe3QR9XqUOV5De7DKAwhwHJIn4emlwAzusdMmFybKTVy34FmONpelpxkI09+tW81I9bPWefR7tC9mU8K6Cn3nYCGvgFxutYw1Xz7tYtiFI3I3e8p3Y18ZrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628680; c=relaxed/simple;
	bh=GC9uYdt4KS07fymuM3NSYxhL9MvirmkNR5XsSlOEbeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YnWAQ1fIXTLI++gzBKmNd5eXQi3Q9D65XvL5Q+09QwNMvA6XsFD0R1ncVdL12fP5mvWF4/dTZoA4q4rUf5POw8sd30P2puNImf1vSetszaNshvEdLtHxlooTVJdhBMIz4wXKRPh80foP6A1pfAHag5u43XdNnL6C14DhmOIB5ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j5OLBnpr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NUnVtHAs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j5OLBnpr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NUnVtHAs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j5OLBnpr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NUnVtHAs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j5OLBnpr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NUnVtHAs"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 531D72117E;
	Thu, 23 Jan 2025 10:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737628676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwElIuMESkHawfK25L5K4feRdFtcRaanmIbm0q1JuoM=;
	b=j5OLBnprbJ+Q9D1+Whj6Ma7EQzwCeCix17crcPsfU5C71LVEK7enHOn127kJlDVtAzEJvB
	wAwN7Iyls5Ek8x2EGrPg2d2QrqU0Fph3BQRjUcP8jUTvsOsTKK/D9an7ouKsIQIDInY8X7
	iPVdjyKSUvbc/XixUwXGvJG6o7zRJjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737628676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwElIuMESkHawfK25L5K4feRdFtcRaanmIbm0q1JuoM=;
	b=NUnVtHAs2IGVZeowl1Nhf5Fv+i2x3tGq2tq8SYA/Cb6vj1Payt8CtFwER0n7cf30oDxhU5
	fOZLc968+jXNO6Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737628676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwElIuMESkHawfK25L5K4feRdFtcRaanmIbm0q1JuoM=;
	b=j5OLBnprbJ+Q9D1+Whj6Ma7EQzwCeCix17crcPsfU5C71LVEK7enHOn127kJlDVtAzEJvB
	wAwN7Iyls5Ek8x2EGrPg2d2QrqU0Fph3BQRjUcP8jUTvsOsTKK/D9an7ouKsIQIDInY8X7
	iPVdjyKSUvbc/XixUwXGvJG6o7zRJjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737628676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwElIuMESkHawfK25L5K4feRdFtcRaanmIbm0q1JuoM=;
	b=NUnVtHAs2IGVZeowl1Nhf5Fv+i2x3tGq2tq8SYA/Cb6vj1Payt8CtFwER0n7cf30oDxhU5
	fOZLc968+jXNO6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3444313A5B;
	Thu, 23 Jan 2025 10:37:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gDt0DAQckmdrAQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 23 Jan 2025 10:37:56 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 23 Jan 2025 11:37:19 +0100
Subject: [PATCH RFC 2/4] rcu: remove trace_rcu_kvfree_callback
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-slub-tiny-kfree_rcu-v1-2-0e386ef1541a@suse.cz>
References: <20250123-slub-tiny-kfree_rcu-v1-0-0e386ef1541a@suse.cz>
In-Reply-To: <20250123-slub-tiny-kfree_rcu-v1-0-0e386ef1541a@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2762; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=GC9uYdt4KS07fymuM3NSYxhL9MvirmkNR5XsSlOEbeI=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBnkhv8v39EUjnAdbXssma/HuIwh410GUk5XJsV2
 aWJ2mS6tbuJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZ5Ib/AAKCRC74LB10kWI
 mlFrB/9XB0cSa+GSbLHOboEHSo34AX4MdVIdnULTltV8UqQGI2wop2o8P5LtVC88DvpKSnuwiDx
 aFVn9UiybtK/Xh/ObijyalPTc5mFJbKGX0lOzXmSICVUv+y1BLZU0lUaUsaQB0zl29+hX5QQx7A
 0tZmYSmyW9KN8Ne16OyMmIRGv2xiUCSGw5U6G4Vgoz4OY5R9Kfyw53YQ3Is90JtC8YLI4pAR3Ph
 q/EoLopr0cGGRLPPU6lOc1ETjxum6oZBij7P2UhRdXXSJY7GnvQ2X76OUp78XdeszbMRiZcfDX6
 qgr4Buktl+rhHR/4MLU0q4J5gnypiqHnXhyhwPJHH45PhmUL
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[linux.com,google.com,kernel.org,joelfernandes.org,joshtriplett.org,gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,gmail.com,kvack.org,goodmis.org,efficios.com,vger.kernel.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLtsk3gtac773whqka7ht6mdi4)];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Tree RCU does not handle kvfree_rcu() by queueing individual objects by
call_rcu() anymore, thus the tracepoint and associated
__is_kvfree_rcu_offset() check is dead code now. Remove it.

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
index 6af042cde9727c8d7f7e3d88f26ba222d0d9c535..f3d5a9caebd9d0772931725bee93c1e172f8b6da 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2932,13 +2932,8 @@ static int __init rcu_spawn_core_kthreads(void)
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

