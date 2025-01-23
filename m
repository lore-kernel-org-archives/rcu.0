Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22706186A
	for <rcu@vger.kernel.org>; Thu, 23 Jan 2025 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628680; cv=none; b=A4cHYyEXOeq86Yn76Vt2lDF7spG75BxeNaFmX9VqNct5stdA4CQLU3iaQ/QdxXCmF9WlqggFhNgTyrB7tXiyslnrW/eB8lmp31I2Wx/8HUdOu0pPDe8up3Ee5euGqt5SwqQ+fF6AiI80mfpW7pHxVn0ZBY1cWuekC7ct95QVEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628680; c=relaxed/simple;
	bh=jOnO+3feYxqGfo6cg3dZ2QN1txBcqa83UHGveWbkMhI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QhA1QAz6Esuwm7y19CLvXcaJpCTbUeca6R2i3UJroBw74x2tXQBO7PCmcov6UTq4G5I/XNF5eLVLb7rqlgKr0dYpj9ba/xvnfmb4DUbNx8sgBnzSufFJ8Lf5n244Ksv+Qau87uXwLqT26ZERfbJC3An9trCGSTp35EbNDJ65nrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XsItYHK9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZvHlEfVV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XsItYHK9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZvHlEfVV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XsItYHK9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZvHlEfVV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XsItYHK9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZvHlEfVV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B3322117C;
	Thu, 23 Jan 2025 10:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737628676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HcOzQzth9ZYVbnoeeavKSigPkt8n9O5lbZ1q+vP3920=;
	b=XsItYHK9y4TtcrydA+aWqkQPH5k8MA+CVDk5yWHJrQV5C8mTi27g+6lrO0HrrQ7ycYJ8yy
	JnOIw80PvQqAtc5OiVVPleHoxYSrY3f6A4BQ/JfFh1KLrcRwHYiv1gv+oTN1PF/7vWyfkm
	A1O3PIXJYCTN5JOV4jVq+flTOVhZnQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737628676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HcOzQzth9ZYVbnoeeavKSigPkt8n9O5lbZ1q+vP3920=;
	b=ZvHlEfVVr1R65JrxUfvu9AvVvPy3iNOA7OLNy1ArkIjSMJKxB4Bp8xNDFmgMPHGQiiMJCo
	5rhsD+6CzX2qEpAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737628676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HcOzQzth9ZYVbnoeeavKSigPkt8n9O5lbZ1q+vP3920=;
	b=XsItYHK9y4TtcrydA+aWqkQPH5k8MA+CVDk5yWHJrQV5C8mTi27g+6lrO0HrrQ7ycYJ8yy
	JnOIw80PvQqAtc5OiVVPleHoxYSrY3f6A4BQ/JfFh1KLrcRwHYiv1gv+oTN1PF/7vWyfkm
	A1O3PIXJYCTN5JOV4jVq+flTOVhZnQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737628676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HcOzQzth9ZYVbnoeeavKSigPkt8n9O5lbZ1q+vP3920=;
	b=ZvHlEfVVr1R65JrxUfvu9AvVvPy3iNOA7OLNy1ArkIjSMJKxB4Bp8xNDFmgMPHGQiiMJCo
	5rhsD+6CzX2qEpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1332136A1;
	Thu, 23 Jan 2025 10:37:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ew54OgMckmdrAQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 23 Jan 2025 10:37:55 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH RFC 0/4] slab, rcu: move and consolidate TINY_RCU
 kvfree_rcu() to SLAB
Date: Thu, 23 Jan 2025 11:37:17 +0100
Message-Id: <20250123-slub-tiny-kfree_rcu-v1-0-0e386ef1541a@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN0bkmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyNj3eKc0iTdksy8St3stKLU1Pii5FLdpBQz06S0VCMjozQjJaDOgqL
 UtMwKsKnRSkFuzkqxtbUAzChBqmoAAAA=
X-Change-ID: 20250123-slub-tiny-kfree_rcu-bd65bfe222f2
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3111; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=jOnO+3feYxqGfo6cg3dZ2QN1txBcqa83UHGveWbkMhI=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBnkhv15Pugh4Hb+6+FauqIMVEf11O10wYENj4VZ
 Gt68i2PvESJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZ5Ib9QAKCRC74LB10kWI
 mhwrB/4vpFrTnVhgpR3cksXtvnBQVQDNk6zCa7u1RCJ29uFsCG8MyTBW5wrdkbRFIFe/tlatv1f
 MFmQZss0tG4vZpONxWjvzBZdx2D6JhbB71Ljo5RjuWgx7hWU2WOuZLZtbkBMmMOtOGR389Xv92i
 y8v+G7R3uXYeEVMRXf0QVESPe05N6vYPJOsY1WuHEdr4qy4dtYAqTj1Jyc8OAPBtsxWzVuMj8LQ
 Vs5okCXVSLZN9/3qXOM1KxXHqkaz6IjIzq1T4byEKmyZz7HXO6RJvXu4rNKl/XjMS9tpZei2CgY
 TsEIrODr5Z04pSR0XOo4ehiuDRbPxv2LzA0v+9qz3KEpWJvm
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLtsk3gtac773whqka7ht6mdi4)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,gmail.com,kvack.org,goodmis.org,efficios.com,vger.kernel.org,suse.cz];
	FREEMAIL_TO(0.00)[linux.com,google.com,kernel.org,joelfernandes.org,joshtriplett.org,gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

Following the move of the TREE_RCU batching kvfree_rcu() implementation
to slab, we still have the simple non-batching implementation in tiny
RCU, and RCU implementation specific ifdefs in slab code.

Finish the move and integration into slab. Allow using the simple
call_rcu() based implementation also with tree RCU when SLUB_TINY is
enabled, as its goal is also to limit memory footprint with less concern
for top performance.

In order to avoid RCU having to recognize the fake callback function
pointers (__is_kvfree_rcu_offset()) when handling call_rcu(), implement
a callback that can calculate the object's address from the embedded
rcu_head pointer without knowing the specific offset (previously SLOB
would not have made it possible, but it's gone now).

After this series, AFAIK only the following kvfree_rcu specific code
remains in RCU:

- a call to kfree_rcu_scheduler_running() from rcu_set_runtime_mode()

  - probably necessary and a generic registration interface would be
    unnecessary bloat?

- declarations of kfree_rcu() API in include/linux/rcupdate.h

  - could be moved to slab.h after checking for/fixing up potential
    missing includes

git tree:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/slub-tiny-kfree_rcu

To: Christoph Lameter <cl@linux.com>
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
To: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
To: Josh Triplett <josh@joshtriplett.org>
To: Boqun Feng <boqun.feng@gmail.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Zqiang <qiang.zhang1211@gmail.com>
Cc: rcu@vger.kernel.org

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Vlastimil Babka (4):
      slab, rcu: move TINY_RCU variant of kvfree_rcu() to SLAB
      rcu: remove trace_rcu_kvfree_callback
      rcu, slab: use a regular callback function for kvfree_rcu
      slab: don't batch kvfree_rcu() with SLUB_TINY

 include/linux/rcupdate.h   | 29 ++++++++++++++---------------
 include/linux/rcutiny.h    | 36 ------------------------------------
 include/linux/rcutree.h    |  3 ---
 include/linux/slab.h       | 14 ++++++++++++++
 include/trace/events/rcu.h | 34 ----------------------------------
 kernel/rcu/tiny.c          | 24 ------------------------
 kernel/rcu/tree.c          |  9 ++-------
 mm/Kconfig                 |  4 ++++
 mm/slab.h                  |  2 ++
 mm/slab_common.c           | 32 +++++++++++++++++++++++++-------
 mm/slub.c                  | 42 ++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 103 insertions(+), 126 deletions(-)
---
base-commit: e492fac3657b60b8dd78a6e8ca26d1d14706c7b3
change-id: 20250123-slub-tiny-kfree_rcu-bd65bfe222f2

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>

