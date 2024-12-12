Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563610F2;
	Thu, 12 Dec 2024 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999440; cv=none; b=Awf4vMycrO5a0sKegAMlcJiDsZq15hIPEmjR9gO0x6AhzkI7oJxYpTLTnYTMtDJZGkRXL8RO4GOpbgHTUQksR5DmrkPp+m1KRdnZzwI2edIxfusACauzMIxK0dUZkj+IfDuAkAgG5uGf8pWoiUX8V/ub8mwQNIRUAOsQk6IKQnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999440; c=relaxed/simple;
	bh=JYIXVSkEKRUlowh48LuJjbTtvx4Cfw+mUDvsE1F6NVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNNYosTEwKjnxmKyR4pt26F+xCqajqzANPX2wBIVKmcJlnNKJ5/BOgvqSRDRTvorxCD0ZvpZZ5C2xoRwXV8TCCBFQQy+9ge7SmptW0rwLTMrZbrUVXRR0xqUbdfpH13ulrt96r/bA+6n7MhrqIqgMqXzVwvJ6PH8CYnuTpBVo94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PYRMNLfd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/l91I6Tm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PYRMNLfd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/l91I6Tm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PYRMNLfd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/l91I6Tm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PYRMNLfd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/l91I6Tm"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BFEFD1F445;
	Thu, 12 Dec 2024 10:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733999436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jmt8yBQ6ShXzUXwOUOUaJoeXsGES/8ZDpWR5ho4hHYo=;
	b=PYRMNLfdKfscC0/bLPF1b8/Ame8L0UPHp8QYarL3jTj17qYgByrJvLZXQkHqtSsqtpa1H1
	7hpfD5VNQd9rY7DoSdD+inNJijGHegOZ42rgO6+LLNRmXvDqqOI4tlPVl2hqXg9bvg19OW
	os8mAYjrm7+wP/y2Fyq9lIxxuWE0aWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733999436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jmt8yBQ6ShXzUXwOUOUaJoeXsGES/8ZDpWR5ho4hHYo=;
	b=/l91I6TmfNc31FgmeVw/t2AcMmx8UBSqNkoYgmOUz400VQ06vYQaZzy8CHzhWuFnNeIAID
	uKz/F/UZOA7JeiBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733999436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jmt8yBQ6ShXzUXwOUOUaJoeXsGES/8ZDpWR5ho4hHYo=;
	b=PYRMNLfdKfscC0/bLPF1b8/Ame8L0UPHp8QYarL3jTj17qYgByrJvLZXQkHqtSsqtpa1H1
	7hpfD5VNQd9rY7DoSdD+inNJijGHegOZ42rgO6+LLNRmXvDqqOI4tlPVl2hqXg9bvg19OW
	os8mAYjrm7+wP/y2Fyq9lIxxuWE0aWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733999436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jmt8yBQ6ShXzUXwOUOUaJoeXsGES/8ZDpWR5ho4hHYo=;
	b=/l91I6TmfNc31FgmeVw/t2AcMmx8UBSqNkoYgmOUz400VQ06vYQaZzy8CHzhWuFnNeIAID
	uKz/F/UZOA7JeiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEB4D13939;
	Thu, 12 Dec 2024 10:30:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rPW2KUy7WmdUIwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 12 Dec 2024 10:30:36 +0000
Message-ID: <e683b73f-4bf3-47be-b08a-4fd2fe6adff5@suse.cz>
Date: Thu, 12 Dec 2024 11:30:36 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 0/5] Move kvfree_rcu() into SLAB
Content-Language: en-US
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <20241210164035.3391747-1-urezki@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241210164035.3391747-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kvack.org,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 12/10/24 17:40, Uladzislau Rezki (Sony) wrote:
> Hello!

Hi and thanks!

> This series is based on v6.12 kernel.

Could it be rebased to v6.13-rc1, which is a basis for most -next branches?
Right now patch 5 doesn't apply on v6.13-rc1.

Please also Cc all slab maintainers/reviewers.

> It is an attempt to move the kvfree_rcu()
> into MM from the kernel/rcu/ place. I split the series into a few patches so it
> is easier to follow a migration process.

I think this is not the best approach. The individual diffs are not easy to
follow because they copy code or delete code separately, and not move it in
a single commit. I get a much better overview when I diff the whole series
against baseline, then git highlights pure moves and local changes nicely.

Having moves recorded properly would also make it possible for "git blame
-C" to show changes that were made in the old file before the move, but with
copy and deletion in separate commits it doesn't work.
(but note it seems it doesn't work so great even if I squash everything to
one patch - were the functions reodered?)

And with this approach you also need the temporary changes.

What I think could work better is to do:
- preparatory changes in the existing location
  - splitting out kvfree_rcu_init() and calling separately in start_kernel()
  - renaming shrinkers
  - adjusting the names passed to trace_rcu_...()
  - maybe even adding the CONFIG_TINY_RCU guards even if redundant
- one big move of code between files, hopefully needing no or minimal
adjustments after the preparatory steps

Makes sense?

Thanks,
Vlastimil

> As a result of this series, the main functionality is located under MM.
> 
> Uladzislau Rezki (Sony) (5):
>   rcu/kvfree: Temporary reclaim over call_rcu()
>   mm/slab: Copy main data structures of kvfree_rcu()
>   mm/slab: Copy internal functions of kvfree_rcu()
>   mm/slab: Copy a function of kvfree_rcu() initialization
>   mm/slab: Move kvfree_rcu() into SLAB
> 
>  include/linux/slab.h |   1 +
>  init/main.c          |   1 +
>  kernel/rcu/tree.c    | 866 ------------------------------------------
>  mm/slab_common.c     | 875 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 877 insertions(+), 866 deletions(-)
> 

