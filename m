Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821CC1FF1D6
	for <rcu@vger.kernel.org>; Mon,  3 Feb 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738574972; cv=none; b=FLi1AHB9PbbPhp8/+wwIJIh+zWENQZfnRQKMranHj+glEYVokV6Suocw3p5WoWFveQy61G22mGisPOK9g2GAUeXFWHlqBvhFp8QExcWTFAawFV6mflB6rRV2YnyA9rbLt+4gdavI9d04VjUvGSE/C+Kb590gyujh1Z0MX2AQxjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738574972; c=relaxed/simple;
	bh=vOb2ezZCz0jMwWHIxv+B6TnYuCKlVYrQd8SzcW3ifns=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YCqqn5OdgifHH+wsi5r5tkUp5gQGx4K8bFJjziPdPg530Lg/2FY0l7jYty+ox1Ezvw2jLIrI1RjMZzLvO2+zpbUFmPCBjJ62Qqz6uV25rJAAUIkfrYWVP0fvB++IQFjzF6HcA5oamwzXqFUg+ij53ZkheYMyTta8PuM4cr/OaJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sBMGJ/zh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X/7rN/En; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sBMGJ/zh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X/7rN/En; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sBMGJ/zh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X/7rN/En";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sBMGJ/zh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X/7rN/En"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C538210F5;
	Mon,  3 Feb 2025 09:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738574968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MfZfmqbXeAJR4AoyC4wgDr/6ru6EDZ/hvaXndR4NNN0=;
	b=sBMGJ/zhBkW4MioftulY9t/iGHA6962bMzkH+Bx3NGT6WYz6oE5HOmiozexcNzAk63co6b
	LoGkyzwx3KFqrd3VypRfFF4Ab9E9w9lMG3pt5xg75ZV7JVulVutntjETbXbGvXE0eJ1sW0
	mwVj6Av//HBRvUokVoxahFqkCeS/OnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738574968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MfZfmqbXeAJR4AoyC4wgDr/6ru6EDZ/hvaXndR4NNN0=;
	b=X/7rN/En/0RL/qYZO3ixWkVtJ6DusGgTpXwJNaMePOFHP+q0/dJgE/BDVw/+/XX/cE0g8g
	GTD6MbTOhXJ+ahAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738574968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MfZfmqbXeAJR4AoyC4wgDr/6ru6EDZ/hvaXndR4NNN0=;
	b=sBMGJ/zhBkW4MioftulY9t/iGHA6962bMzkH+Bx3NGT6WYz6oE5HOmiozexcNzAk63co6b
	LoGkyzwx3KFqrd3VypRfFF4Ab9E9w9lMG3pt5xg75ZV7JVulVutntjETbXbGvXE0eJ1sW0
	mwVj6Av//HBRvUokVoxahFqkCeS/OnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738574968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MfZfmqbXeAJR4AoyC4wgDr/6ru6EDZ/hvaXndR4NNN0=;
	b=X/7rN/En/0RL/qYZO3ixWkVtJ6DusGgTpXwJNaMePOFHP+q0/dJgE/BDVw/+/XX/cE0g8g
	GTD6MbTOhXJ+ahAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41D9B13A78;
	Mon,  3 Feb 2025 09:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N6u+D3iMoGfwYAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 03 Feb 2025 09:29:28 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 0/4] slab, rcu: move and consolidate TINY_RCU kvfree_rcu()
 to SLAB
Date: Mon, 03 Feb 2025 10:28:46 +0100
Message-Id: <20250203-slub-tiny-kfree_rcu-v1-0-d4428bf9a8a1@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE6MoGcC/x3MwQpAQBCA4VfRnE0x4uBVJFlmmWhp1ork3W2O3
 +H/H/Cswh7q5AHlU7xsLiJPExjm3k2MMkYDZVRmORXo12DwEHfjYpW50yGgGavSWCYiSxDLXdn
 K9V+b9n0/Y0EEkGUAAAA=
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[linux.com,google.com,kernel.org,joelfernandes.org,joshtriplett.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,gmail.com,kvack.org,goodmis.org,efficios.com,vger.kernel.org,suse.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

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

Changes since RFC [1]:
- Rebased to v6.14-rc1
- Fixed build errors reported by bots.
- Changed where kvfree_call_rcu() is moved to in patch 1 to avoid another
  move in patch 4.
- R-b's by Ulad and Joel
- Fix a memory leak in kvfree_rcu_list() thanks to Ulad
- Various comments' improvements and fixes (Joel, Ulad)
- Rename config to CONFIG_KFREE_RCU_BATCHED (Ulad)

Due to changes, didn't keep Paul's Tested-by (but thanks!)

Will include in slab/for-next if no objection.

[1] https://lore.kernel.org/all/20250123-slub-tiny-kfree_rcu-v1-0-0e386ef1541a@suse.cz/

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

 include/linux/rcupdate.h   | 33 ++++++++++++++++++---------------
 include/linux/rcutiny.h    | 36 ------------------------------------
 include/linux/rcutree.h    |  3 ---
 include/linux/slab.h       | 14 ++++++++++++++
 include/trace/events/rcu.h | 34 ----------------------------------
 kernel/rcu/tiny.c          | 25 -------------------------
 kernel/rcu/tree.c          |  9 ++-------
 mm/Kconfig                 |  4 ++++
 mm/slab.h                  |  2 ++
 mm/slab_common.c           | 33 +++++++++++++++++++++++++++------
 mm/slub.c                  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 113 insertions(+), 126 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250123-slub-tiny-kfree_rcu-bd65bfe222f2

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>

