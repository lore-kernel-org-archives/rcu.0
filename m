Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D71E9900;
	Mon, 20 Jan 2025 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737405343; cv=none; b=UDmMdmlkDP8vsuemUOOzFGLcrEJWqQX8UhYa3GvRz/9KlVc4urbqGzr4sNokpUbnI//3GVkUew0IGjGi1/3yl9ZIXDQqwziM/DWyVbX9isFQNuY1O+Ape6TpaZeqxhUQ9J8uZInAMzXZsTxXJBymzov3AZCxvzfRN+JlqXWVh1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737405343; c=relaxed/simple;
	bh=Qcezwlq6i2xNFSsUukDPiQNWq1xkMyPdEkC7GPlyfVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KY/v4+so3bBpE4cOprLjoZz8VektsLwgaopD398PV4QoWOp7V/eWxYi774Zk7LG+jqy3bMQHsbPtCxspaBVjjHVbjPv2db5S0gNwwYwkR8qWgpggXrS4DLVPHbFFoJSoFJHZrCSJcAm2o+hsphbTNwOpnuTNbIHA02Yh1Jj8mxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R47d1pRN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=27uwELbi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PuPJn6uZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zeVG1kfw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R47d1pRN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="27uwELbi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PuPJn6uZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zeVG1kfw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC72A21164;
	Mon, 20 Jan 2025 20:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737405339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yXvc+oEPx5XaZth0KQE2dzPEEgMGO6xaC8Fe2INF7LU=;
	b=R47d1pRNzRVLwl6NEX5rubDeXXhkYayhUBehou6wet1L2iqvP6PykWmxf3JfhBb+85jb8j
	XDj6xJVxZl7O4vvHJyTaY1eQdECZJuReLm5WyoVxrmFcXLOIGZlC2OcpiBo8KxapRhnjvY
	5o6LCJzE3/EboiZSJ3Bw4uERWyd/8XI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737405339;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yXvc+oEPx5XaZth0KQE2dzPEEgMGO6xaC8Fe2INF7LU=;
	b=27uwELbiCF8bIg9QA9wDh6mcDbdy9CjO1EsB4fpQeIKSgQB3PXsD5C0g+zUN7Re3Sg8O8u
	34tFz6Pe89vV3KBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737405338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yXvc+oEPx5XaZth0KQE2dzPEEgMGO6xaC8Fe2INF7LU=;
	b=PuPJn6uZoS2pxfXDzfGr2NqWXkicnvlYZVdMLy+isGD4zJdYVE/GfW+IZHI1mErK5UgmPv
	4mTSDj99FzBh5nKnh6F3LEUsGCgdNiwFri0gQJqMhyuo//rkGKW9qp39lbWiD9YMY83o8u
	zAhPE8fWc+u547nXOw0Kl6dTT52PjhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737405338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yXvc+oEPx5XaZth0KQE2dzPEEgMGO6xaC8Fe2INF7LU=;
	b=zeVG1kfw8dDWPQ7d3As2ItIiE3mGahQ05M4cnHlF7jAdAhY5De25aPBFDBk85GxwunduiA
	ea7vXD75AJSfFwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1E14139CB;
	Mon, 20 Jan 2025 20:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RxCeMJqzjmfVNAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 20 Jan 2025 20:35:38 +0000
Message-ID: <0e2d61be-39a4-4837-81ac-bd8b2fb7a37f@suse.cz>
Date: Mon, 20 Jan 2025 21:35:38 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] slab updates for 6.14
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
References: <3154387b-c045-401e-800c-f5d05be033e4@suse.cz>
 <Z46N0lAqUwQ3Z5S6@lappy>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJkBREIBQkRadznAAoJECJPp+fMgqZkNxIQ
 ALZRqwdUGzqL2aeSavbum/VF/+td+nZfuH0xeWiO2w8mG0+nPd5j9ujYeHcUP1edE7uQrjOC
 Gs9sm8+W1xYnbClMJTsXiAV88D2btFUdU1mCXURAL9wWZ8Jsmz5ZH2V6AUszvNezsS/VIT87
 AmTtj31TLDGwdxaZTSYLwAOOOtyqafOEq+gJB30RxTRE3h3G1zpO7OM9K6ysLdAlwAGYWgJJ
 V4JqGsQ/lyEtxxFpUCjb5Pztp7cQxhlkil0oBYHkudiG8j1U3DG8iC6rnB4yJaLphKx57NuQ
 PIY0Bccg+r9gIQ4XeSK2PQhdXdy3UWBr913ZQ9AI2usid3s5vabo4iBvpJNFLgUmxFnr73SJ
 KsRh/2OBsg1XXF/wRQGBO9vRuJUAbnaIVcmGOUogdBVS9Sun/Sy4GNA++KtFZK95U7J417/J
 Hub2xV6Ehc7UGW6fIvIQmzJ3zaTEfuriU1P8ayfddrAgZb25JnOW7L1zdYL8rXiezOyYZ8Fm
 ZyXjzWdO0RpxcUEp6GsJr11Bc4F3aae9OZtwtLL/jxc7y6pUugB00PodgnQ6CMcfR/HjXlae
 h2VS3zl9+tQWHu6s1R58t5BuMS2FNA58wU/IazImc/ZQA+slDBfhRDGYlExjg19UXWe/gMcl
 De3P1kxYPgZdGE2eZpRLIbt+rYnqQKy8UxlszsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZAUSmwUJDK5EZgAKCRAiT6fnzIKmZOJGEACOKABgo9wJXsbWhGWYO7mD
 8R8mUyJHqbvaz+yTLnvRwfe/VwafFfDMx5GYVYzMY9TWpA8psFTKTUIIQmx2scYsRBUwm5VI
 EurRWKqENcDRjyo+ol59j0FViYysjQQeobXBDDE31t5SBg++veI6tXfpco/UiKEsDswL1WAr
 tEAZaruo7254TyH+gydURl2wJuzo/aZ7Y7PpqaODbYv727Dvm5eX64HCyyAH0s6sOCyGF5/p
 eIhrOn24oBf67KtdAN3H9JoFNUVTYJc1VJU3R1JtVdgwEdr+NEciEfYl0O19VpLE/PZxP4wX
 PWnhf5WjdoNI1Xec+RcJ5p/pSel0jnvBX8L2cmniYnmI883NhtGZsEWj++wyKiS4NranDFlA
 HdDM3b4lUth1pTtABKQ1YuTvehj7EfoWD3bv9kuGZGPrAeFNiHPdOT7DaXKeHpW9homgtBxj
 8aX/UkSvEGJKUEbFL9cVa5tzyialGkSiZJNkWgeHe+jEcfRT6pJZOJidSCdzvJpbdJmm+eED
 w9XOLH1IIWh7RURU7G1iOfEfmImFeC3cbbS73LQEFGe1urxvIH5K/7vX+FkNcr9ujwWuPE9b
 1C2o4i/yZPLXIVy387EjA6GZMqvQUFuSTs/GeBcv0NjIQi8867H3uLjz+mQy63fAitsDwLmR
 EP+ylKVEKb0Q2A==
In-Reply-To: <Z46N0lAqUwQ3Z5S6@lappy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,linux.com,kvack.org,vger.kernel.org,linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 1/20/25 18:54, Sasha Levin wrote:
> On Fri, Jan 17, 2025 at 03:13:18PM +0100, Vlastimil Babka wrote:
>>Hi Linus,
>>
>>please pull the latest slab updates from:
>>
>>  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.14
> 
> Hi Vlastimil,

Hi,

> I've ended up pulling quite a few of the 6.14 PRs into linus-next, and
> LKFT started hitting the following issue:
> 
> <1>[  526.258666] Unable to handle kernel paging request at virtual address 00000007f5b55088
> <1>[  526.260217] Mem abort info:
> <1>[  526.260902]   ESR = 0x0000000096000005
> <1>[  526.261422]   EC = 0x25: DABT (current EL), IL = 32 bits
> <1>[  526.262197]   SET = 0, FnV = 0
> <1>[  526.262684]   EA = 0, S1PTW = 0
> <1>[  526.263370]   FSC = 0x05: level 1 translation fault
> <1>[  526.267546] Data abort info:
> <1>[  526.268047]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> <1>[  526.268688]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> <1>[  526.269601]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> <1>[  526.270143] user pgtable: 64k pages, 52-bit VAs, pgdp=0000000103f42000
> <1>[  526.279321] [00000007f5b55088] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
> <0>[  526.284271] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> <4>[  526.285819] Modules linked in: tun sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 fuse drm backlight ip_tables x_tables
> <4>[  526.288412] CPU: 0 UID: 0 PID: 5334 Comm: read_all Not tainted 6.13.0 #1
> <4>[  526.290169] Hardware name: linux,dummy-virt (DT)
> <4>[  526.291025] pstate: a3402009 (NzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> <4>[  526.291607] pc : kfree+0x60/0x350
> <4>[  526.292404] lr : show_slab_objects+0x31c/0x438
> <4>[  526.292796] sp : ffff8000882efb40
> <4>[  526.293761] x29: ffff8000882efb50 x28: 0000000000000000 x27: ffffa0d6d542a8f0
> <4>[  526.295127] x26: fff00000c0000b40 x25: ffffa0d6d5379000 x24: 0000000000000001
> <4>[  526.296745] x23: ffffa0d6d5379d40 x22: ffffa0d6d4aba898 x21: 6cefa0d6d2dab76c
> <4>[  526.297465] x20: ffffa0d6d542a8f0 x19: 00000007f5b55080 x18: ffffffffffffffff
> <4>[  526.299121] x17: 0000000000000000 x16: 0000000000000000 x15: ffff8000882ef9e0
> <4>[  526.300133] x14: fff00000c0540000 x13: fff00000c0530000 x12: 0000000000000000
> <4>[  526.301642] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffa0d6d2dab76c
> <4>[  526.302368] x8 : fff00000ff060000 x7 : ffff8000882efba0 x6 : ffff8000882efba0
> <4>[  526.303575] x5 : 00000000ffffffd8 x4 : fff00000ff060608 x3 : 0000000000000000
> <4>[  526.304506] x2 : 0000000000000000 x1 : fff00000ff060000 x0 : fffffc1fc0000000
> <4>[  526.305547] Call trace:
> <4>[  526.306310]  kfree+0x60/0x350 (P)
> <4>[  526.307446]  show_slab_objects+0x31c/0x438

This is typically a corrupted slab freelist due to double free or
use-after-free, here it indirectly hits the slab's code that handles sysfs
cache stats reporting (probably of some other cache that's fine), because
that function does a kmalloc/kfree and happens to use the corrupted slab.

> <4>[  526.307948]  total_objects_show+0x1c/0x30
> <4>[  526.308514]  slab_attr_show+0x28/0x48
> <4>[  526.308812]  sysfs_kf_seq_show+0x9c/0x148
> <4>[  526.309901]  kernfs_seq_show+0x34/0x48
> <4>[  526.310922]  seq_read_iter+0xe4/0x460
> <4>[  526.311704]  kernfs_fop_read_iter+0x148/0x1c0
> <4>[  526.312903]  vfs_read+0x280/0x330
> <4>[  526.314276]  ksys_read+0x78/0x118
> <4>[  526.316078]  __arm64_sys_read+0x24/0x38
> <4>[  526.316651]  invoke_syscall.constprop.0+0x58/0xf8
> <4>[  526.317315]  do_el0_svc+0x48/0xd8
> <4>[  526.317811]  el0_svc+0x40/0x160
> <4>[  526.319521]  el0t_64_sync_handler+0x10c/0x138
> <4>[  526.320220]  el0t_64_sync+0x198/0x1a0
> <0>[  526.321602] Code: b26287e0 d350fe73 f2df83e0 8b131813 (f9400660)
> <4>[  526.322715] ---[ end trace 0000000000000000 ]---
> <4>[  536.656232] ------------[ cut here ]------------
> <4>[  536.656871] Trying to vfree() bad address (00000000a5fbfd52)
> <4>[  536.658605] WARNING: CPU: 1 PID: 31 at mm/vmalloc.c:3231 remove_vm_area+0x68/0x90

Perhaps this implicates some vmalloc changes or it's also a victim of
somebody else causing a corruption. It does use kmalloc/kfree too so could
be even due to corruption of the same slab as above.

I think the slab PR itself has nothing that could affect this it's mostly
just a code move from RCU to SLAB.

Bisecting might indeed work best, or you could try KASAN or at least booting
with slub_debug to catch whoever is misbehaving.

> <4>[  536.660181] Modules linked in: tun sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 fuse drm backlight ip_tables x_tables
> <4>[  536.662159] CPU: 1 UID: 0 PID: 31 Comm: kworker/1:1 Tainted: G      D            6.13.0 #1
> <4>[  536.663261] Tainted: [D]=DIE
> <4>[  536.664160] Hardware name: linux,dummy-virt (DT)
> <4>[  536.665493] Workqueue: events delayed_vfree_work
> <4>[  536.666020] pstate: 62402009 (nZCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> <4>[  536.667232] pc : remove_vm_area+0x68/0x90
> <4>[  536.667917] lr : remove_vm_area+0x68/0x90
> <4>[  536.668448] sp : ffff80008092fc90
> <4>[  536.668759] x29: ffff80008092fc90 x28: 0000000000000000 x27: 0000000000000000
> <4>[  536.670302] x26: 0000000000000000 x25: 0000000000000000 x24: fff00000c02f0205
> <4>[  536.671148] x23: fff00000fdaf3180 x22: 0000000000000000 x21: 0000000000000000
> <4>[  536.672118] x20: ffffa0d6d542a8f0 x19: ffffa0d6d542a8f0 x18: 0000000000000006
> <4>[  536.673098] x17: fff05f2a288b0000 x16: ffff800080020000 x15: ffff80008092f6c0
> <4>[  536.673718] x14: ffff80010092f87a x13: ffff80008092f882 x12: 0000000000000000
> <4>[  536.674718] x11: fffffffffffe0000 x10: ffffa0d6d53f82b0 x9 : ffffa0d6d2b4c7c4
> <4>[  536.675772] x8 : 00000000ffffefff x7 : ffffa0d6d53f82b0 x6 : 80000000fffff000
> <4>[  536.676801] x5 : 0000000000000181 x4 : 0000000000000000 x3 : 0000000000000000
> <4>[  536.677609] x2 : 0000000000000000 x1 : 0000000000000000 x0 : fff00000c0842600
> <4>[  536.679075] Call trace:
> <4>[  536.679415]  remove_vm_area+0x68/0x90 (P)
> <4>[  536.679795]  vfree+0x44/0x338
> <4>[  536.680241]  kvfree+0x2c/0x60
> <4>[  536.681397]  vfree+0x134/0x338
> <4>[  536.681989]  delayed_vfree_work+0x44/0x60
> <4>[  536.682344]  process_one_work+0x158/0x3c0
> <4>[  536.683428]  worker_thread+0x2d8/0x3e8
> <4>[  536.684162]  kthread+0x120/0x208
> <4>[  536.684778]  ret_from_fork+0x10/0x20
> <4>[  536.685509] ---[ end trace 0000000000000000 ]---
> 
> I'm working on bisecting, but sending this mail out in hopes that we can
> figure it out from the logs. The full logs are at: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.13-rc7-1168-g45696205640c/testrun/26824158/suite/log-parser-test/test/bug-bug-bad-rss-counter-state-mmeadba-typemm_anonpages-val/log
> 

