Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA03176F9
	for <rcu@vger.kernel.org>; Sat, 16 Aug 2025 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755369110; cv=none; b=L7FveMaC6B0JAMcNffV0/ebsZ9q07mtjNP1xyFqnFkGoaRY6YFNmDiyc4TR3P/lmmygE47/mgmPDsKCrl2MvuapYEehHQZbUNwmQPiuIKzmASShMstjMT45xYPBFswZYzSSMoJN2KcDKeXeZzkaTaG928pHJ3JDQZX55omu6Ebw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755369110; c=relaxed/simple;
	bh=DbXnO8ZIOKmPwWFYuK0vi5yqtT99n28HsveQ3DSmlEo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oMGNyqbei3Q3bT2BUx4Tprpac+N/Kl1Rqy6b6TkoaChS2KxeuVVg6Zkvxd5dE8LtGQp0e9twGKU9YR9lromQTmXSgvshHPX+tghH3Ym4AOLGfFMdsYTsm3euWg/yZzmGk7+KOxokwAKrp8QHipqNTK3upglaE/ephciRMtVi+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a67ON98K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kiip+/on; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bKVvBBTY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f93zNYiR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a67ON98K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kiip+/on";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bKVvBBTY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f93zNYiR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0613218A2;
	Sat, 16 Aug 2025 18:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755369101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZ3PzzQW4uU5pO1+Nv8StLCU9Y2RLWdIj4dVek3lkDI=;
	b=a67ON98KsieZnR/spc10Co8TpfbvY3xcYpL8D2IEq/J1Gyl+7pejh9tT6uPZLa8zA30bKW
	GAnBLDQZW1WWFtCPhNJCKERpc/zSWDdIjpdD+LvMUeKWmfLEYzoWV2DuwDzmNSlctd+Yc3
	oLUzEHam25aon1K7Ry2NmftuNCvMdvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755369101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZ3PzzQW4uU5pO1+Nv8StLCU9Y2RLWdIj4dVek3lkDI=;
	b=kiip+/on8sp6CwHWeBqziZ4ozj58C4JBiB/8t7IZn2JxYTGXh6BpG0z7cUW2A0Ua8djjWc
	wj7AW7OtMvc0M1Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bKVvBBTY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=f93zNYiR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755369100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZ3PzzQW4uU5pO1+Nv8StLCU9Y2RLWdIj4dVek3lkDI=;
	b=bKVvBBTYYLXnsNrbclQiGjxZ3ubzGm9CanfHWACJkm7FavAwLfUMFpl8Ew3rYSc1HwWvl4
	laEm0Q6xqT15DLksm0Va/baEjWoPVOez0gXvnJIhjmkyo3gepp5mEyP44XYWg440X4QC5K
	Lli6ht6CzzwXAj9cU8tnnwzCUbSBWe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755369100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZ3PzzQW4uU5pO1+Nv8StLCU9Y2RLWdIj4dVek3lkDI=;
	b=f93zNYiR2qbUNvmFmi3gy8tpI5JmBwwIPaCI2QFZnL3PZ+PCGoBGzToZigb3ypIj1yvGTG
	WL/pYKM1BwMiP7BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72EAA13432;
	Sat, 16 Aug 2025 18:31:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LqE2GozOoGgqCAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sat, 16 Aug 2025 18:31:40 +0000
Message-ID: <22666e86-2523-4136-94e6-0de126fcec1e@suse.cz>
Date: Sat, 16 Aug 2025 20:33:47 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/14] SLUB percpu sheaves
From: Vlastimil Babka <vbabka@suse.cz>
To: Sudarsan Mahendran <sudarsanm@google.com>,
 Harry Yoo <harry.yoo@oracle.com>
Cc: Liam.Howlett@oracle.com, cl@gentwo.org, howlett@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 maple-tree@lists.infradead.org, rcu@vger.kernel.org, rientjes@google.com,
 roman.gushchin@linux.dev, surenb@google.com, urezki@gmail.com,
 Greg Thelen <gthelen@google.com>
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250815225259.3012455-2-sudarsanm@google.com> <aKA7180s0HdLfOKc@harry>
 <CAA9mObAiQbAYvzhW---VoqDA6Zsb152p5ePMvbco0xgwyvaB2Q@mail.gmail.com>
 <498fc518-d78a-43a4-9196-507891e9b844@suse.cz>
Content-Language: en-US
In-Reply-To: <498fc518-d78a-43a4-9196-507891e9b844@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,gentwo.org,gmail.com,vger.kernel.org,kvack.org,lists.infradead.org,google.com,linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: F0613218A2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 8/16/25 8:31 PM, Vlastimil Babka wrote:
>>
>> I assume somehow the free_to_pcs_bulk() fallback case is taken, thus
>> calling __kmem_cache_free_bulk(), which calls free_to_pcs_bulk() ad nauseam.
> Could it be a rebase gone wrong? Mine to 6.17-rc1 is here (but untested)
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/

This branch specifically
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/slub-percpu-sheaves
