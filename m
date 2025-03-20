Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7088A2557C
	for <rcu@vger.kernel.org>; Thu, 20 Mar 2025 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476012; cv=none; b=i/9JxHpNXbRtp1b5gHs+7HvUWlnRrQF7WIJj9BwAqdI751pxprTXjG+wxJhgpcYl0iHWVTqDyKeiljBBdSwX95/ak5GRPrb3SjYUXJCJK9ErWL21Iwt8xmSrec2xHnT5nLbfxuQ5T/XRUyezsOq2bVAxZSixaJC8G8x4eUrbaVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476012; c=relaxed/simple;
	bh=TpUMnvL90k+sp8B1Gje0xvXKn3ZcYg/Zz4GVYCjOvGA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=XHVpu8IiP9mZybZhiWoVnHFXC8y/e0Cy9p+C1rbAJ+AKPhw3M5A6CFxvvM/ZCRo5Punikns/1EzAVBCKPXgQzMEfnm4/QYQI1Do2ihaQtzuELSMILBqlcEiqaZZY/3d8mcYq+UVdhWhWgGgxmMxNW4TZoS4UQBAu710tCVArKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ckpo6gGm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hOp6FQHF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ckpo6gGm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hOp6FQHF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ckpo6gGm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hOp6FQHF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ckpo6gGm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hOp6FQHF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5D9E21AE1;
	Thu, 20 Mar 2025 13:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742476002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DVM0zWMbQyxQGTtaw+uEZlRi+uUw4hPbnR8TPmrRoJg=;
	b=ckpo6gGmjY1fqVsM7bTC6gCJ2Z6PMrmHiculLuJILQeiip8+Rqzi8b+/lFl6eyuM/wIgIL
	ZMtHoDbzOOluoHKAg+eXTeXs2ahx4nFY0YauBJIg2i+DTz8du2M6+OS+Ucl3b7WEBdfuLv
	S1REuAk2rBIjUchE4r2tT3UCR8z1l7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742476002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DVM0zWMbQyxQGTtaw+uEZlRi+uUw4hPbnR8TPmrRoJg=;
	b=hOp6FQHFyT0ayDmccMjHq6PmlJo7IdaIVT0/kQ8tCYZheo8NE02RQ/NrtHSIdffu1lfCCi
	EBNoP2pHU3u7iHCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ckpo6gGm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hOp6FQHF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742476002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DVM0zWMbQyxQGTtaw+uEZlRi+uUw4hPbnR8TPmrRoJg=;
	b=ckpo6gGmjY1fqVsM7bTC6gCJ2Z6PMrmHiculLuJILQeiip8+Rqzi8b+/lFl6eyuM/wIgIL
	ZMtHoDbzOOluoHKAg+eXTeXs2ahx4nFY0YauBJIg2i+DTz8du2M6+OS+Ucl3b7WEBdfuLv
	S1REuAk2rBIjUchE4r2tT3UCR8z1l7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742476002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DVM0zWMbQyxQGTtaw+uEZlRi+uUw4hPbnR8TPmrRoJg=;
	b=hOp6FQHFyT0ayDmccMjHq6PmlJo7IdaIVT0/kQ8tCYZheo8NE02RQ/NrtHSIdffu1lfCCi
	EBNoP2pHU3u7iHCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9ABE6139D2;
	Thu, 20 Mar 2025 13:06:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IiIsJeIS3GdrQgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 20 Mar 2025 13:06:42 +0000
Message-ID: <2f7985a8-0460-42de-9af0-4f966b937695@suse.cz>
Date: Thu, 20 Mar 2025 14:06:42 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab updates for 6.15
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B5D9E21AE1
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux.com,linux-foundation.org,kvack.org,vger.kernel.org,linux.dev,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi Linus,

please pull the latest slab updates from:

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.15

There's a small conflict with the rcu tree:
https://lore.kernel.org/all/20250212150941.5e4fa1c9@canb.auug.org.au/

Thanks,
Vlastimil

======================================

* Move the TINY_RCU kvfree_rcu() implementation from RCU to SLAB
  subsystem and cleanup its integration (Vlastimil Babka)

  Following the move of the TREE_RCU batching kvfree_rcu() implementation in
  6.14, move also the simpler TINY_RCU variant. Refactor the #ifdef guards
  so that the simple implementation is also used with SLUB_TINY. Remove the
  need for RCU to recognize fake callback function pointers
  (__is_kvfree_rcu_offset()) when handling call_rcu() by implementing a
  callback that calculates the object's address from the embedded rcu_head
  address without knowing its offset.

* Improve kmalloc cache randomization in kvmalloc (GONG Ruiqi)

  Due to an extra layer of function call, all kvmalloc() allocations used the
  same set of random caches. Thanks to moving the kvmalloc() implementation to
  slub.c, this is improved and randomization now works for kvmalloc.

* Various improvements to debugging, testing and other cleanups (Hyesoo Yu,
  Lilith Gkini, Uladzislau Rezki, Matthew Wilcox, Kevin Brodsky, Ye Bin)

----------------------------------------------------------------
GONG Ruiqi (2):
      slab: Adjust placement of __kvmalloc_node_noprof
      slab: Achieve better kmalloc caches randomization in kvmalloc

Hyesoo Yu (2):
      mm: slub: Print the broken data before restoring them
      mm: slub: call WARN() when detecting a slab corruption

Kevin Brodsky (1):
      mm/slab: simplify SLAB_* flag handling

Lilith Gkini (1):
      slub: Handle freelist cycle in on_freelist()

Matthew Wilcox (Oracle) (1):
      slab: Mark large folios for debugging purposes

Uladzislau Rezki (Sony) (1):
      kunit, slub: Add test_kfree_rcu_wq_destroy use case

Vlastimil Babka (6):
      slab, rcu: move TINY_RCU variant of kvfree_rcu() to SLAB
      rcu: remove trace_rcu_kvfree_callback
      rcu, slab: use a regular callback function for kvfree_rcu
      slab: don't batch kvfree_rcu() with SLUB_TINY
      mm, slab: cleanup slab_bug() parameters
      Merge branch 'slab/for-6.15/kfree_rcu_tiny' into slab/for-next

Ye Bin (1):
      mm/slab: call kmalloc_noprof() unconditionally in kmalloc_array_noprof()

 include/linux/page-flags.h |  18 +--
 include/linux/rcupdate.h   |  33 +++--
 include/linux/rcutiny.h    |  36 -----
 include/linux/rcutree.h    |   3 -
 include/linux/slab.h       |  16 ++-
 include/trace/events/rcu.h |  34 -----
 kernel/rcu/tiny.c          |  25 ----
 kernel/rcu/tree.c          |   9 +-
 lib/slub_kunit.c           |  59 ++++++++
 mm/Kconfig                 |   4 +
 mm/slab.h                  |  34 +----
 mm/slab_common.c           |  44 ++++--
 mm/slub.c                  | 336 ++++++++++++++++++++++++++++++++++++++-------
 mm/util.c                  | 162 ----------------------
 14 files changed, 430 insertions(+), 383 deletions(-)
