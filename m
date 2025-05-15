Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F108929827D
	for <rcu@vger.kernel.org>; Thu, 15 May 2025 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313176; cv=none; b=UIv40vltIdlFbZAPLYsPuQIAn878ovWK9HdMkhZX9kpSPn+VSw8EzY1ZRA8Cs8D0g+Tlp/T0iUhUXoRVp0Ml+I8NPgWpPqKixsggcr5hJ5XA7fn+IMUbnEalZbWbPowP/lUTAbOvQIJk0/6GgT/MqUo8I+Qe5hNjH9jP1Sbyejo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313176; c=relaxed/simple;
	bh=XW7PBHOKBmG5yJC+Rl2iAib7QxCqoJW99UU7ERZwn34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNb/ZpaevAAaKtScPkfeAdXpXiFbcvNXBb5mv5nfmhOrSyEvWPMY2va06x+mggCN1HfUha4ncVHqZomvlB9aUY2mIvUal158SgLWiGBsV5sS0GLqyeZK6UtmR9nbzk+CUU4c91mOIz0lZ2koHI3XTKvEn0640EbdrrDKJ4OYEBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GK29OhNb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hunZINYK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cFgi9d4b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dy0J38kS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GK29OhNb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hunZINYK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cFgi9d4b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dy0J38kS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E42C721172;
	Thu, 15 May 2025 12:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747313173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BsKlAkmZ3syr3tHGBds0epgCENVPz/kzS4L9nJzEOyI=;
	b=GK29OhNbIIa7azCMPoOtjO5YGw/ZMFyhZwXtPguFLXr9lpRs98web3/lmqBbKB3ebJ/x16
	Mj1uGIYM5sPS1EHJa+j1UmGyLqMxjBdyTu/mFgNqLJ07+onfXTUz9cuhRsZ1Fn5Qzp3t6r
	BT9jiOmJ/5RcvE8jNVN2noXb82yzH7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747313173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BsKlAkmZ3syr3tHGBds0epgCENVPz/kzS4L9nJzEOyI=;
	b=hunZINYK7D505Um/vk4LzjLvqlG8Gbdyba6+IpEMcKVDXPwFA42ppvvhh5xFXFCqGTQ0sk
	R4HpQ1jFbARZb0Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cFgi9d4b;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Dy0J38kS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747313172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BsKlAkmZ3syr3tHGBds0epgCENVPz/kzS4L9nJzEOyI=;
	b=cFgi9d4bTa8gcJ9S/0KtR7qxk/kEhUnvtaBotInkpOmsXnQmQBoybZ3NpsU1u9Kvqa6RIc
	BU5crVfvjFOZhG+0CGG91vlk+rCpLA+B8TiaGb9Mvt5XWDaMPlf40bRE0qCv4pCb3tkTHU
	LnsQakG61rr+WtZG+CgGMxRVvg4Buwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747313172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BsKlAkmZ3syr3tHGBds0epgCENVPz/kzS4L9nJzEOyI=;
	b=Dy0J38kSFN2SXRR4mSd6mp2EU+OXx+Z8xIn6ipsQjk2EpJKOYkgAEAcTT5LiDBtUr3QXIc
	gF/CWCGOlfIuNMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA677137E8;
	Thu, 15 May 2025 12:46:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EoEKMRTiJWjNDwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 May 2025 12:46:12 +0000
Message-ID: <266cb5e2-f946-414a-bc08-193c7e6e5f19@suse.cz>
Date: Thu, 15 May 2025 14:46:12 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] SLUB percpu sheaves
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter
 <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E42C721172
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 4/25/25 10:27, Vlastimil Babka wrote:
> Hi,
> 
> This is the v4 and first non-RFC series to add an opt-in percpu
> array-based caching layer to SLUB, following the LSF/MM discussions.
> Since v3 I've also made changes to achieve full compatibility with
> slub_debug, and IRC discussions led to the last patch intended to
> improve NUMA locality (the patch remains separate for evaluation
> purposes).

I've pushed the changes based on the feedback here:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/slub-percpu-sheaves

You can use that for testing/benchmarking. Thanks!
