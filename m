Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CE92F3C3A
	for <rcu@vger.kernel.org>; Wed,  3 Dec 2025 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764760526; cv=none; b=NRiRG2ubpheU569OBNxLu9o6AbbiPKE5PRurSUxEnso3HPvWm1e4aERllH7DfxmmHAn+loa76CwIhsZ2NwhNaDXpOgrXWJUPZHy1FKS8fEeQOYzyiHxmeQBossZaxXCeWEw4odFTjttPPCuTXQftBsurnpqb/f1kp18VXA9D6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764760526; c=relaxed/simple;
	bh=aYnebBiTt81TJYwSLST5fbtEPiT8IjdZwIB9Xqc/3ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IehRu1NZBoXQlJ6P7bye0K03OxOP06cckYlRoYlaqQ4W1D2vPBKOkSdk0q94kozxnyUeYI2KesQxK+L/2OOwwKstIoT2xXGqGgrfnU6TQq7BHXM0m+mlG9ab5Wt3/5Vqcj2HZ9HuMjpQ4TN2bFchSOep4mZXJShIQZvjW+mKRZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcC3Yevh; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcC3Yevh"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-bde0f62468cso6513384a12.2
        for <rcu@vger.kernel.org>; Wed, 03 Dec 2025 03:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764760524; x=1765365324; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4liKJMDGkOIyeh/41fba3sjQmLKDAy3L+mDjIKGTwug=;
        b=gcC3YevhvkSrEBxd8cQjblLN1tqxvMcXdNwG5lI2zGhER3r3IDproOQXBg248HoFPs
         v80mtt7yC9cpyrkrmK3vtZdj0B+IQNtZZmbrJP1BbPIPrymtuTt9TuOrZ1NvAMF2VbSq
         I7ZDGywBUHOzEHMiRPzHRsguatyh/wXeYgEOsxr7UNbcogXM7j+QmYHJerOoprGbBn7K
         AOFlXRpq4i0IdwI1DF5iDmxosE0YxL4CY+RoaowxYnbV2CMzjPzgnC39hPoYmw1/1V8V
         WRY7YfpnA3pUxs3D9Yo5Rizocp5mh0tFRbUNhT6zaSfuZDNETz5kEyNo/IsmgbKzXk8c
         3KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764760524; x=1765365324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4liKJMDGkOIyeh/41fba3sjQmLKDAy3L+mDjIKGTwug=;
        b=YLaH96dEMgJp6UYojzvo3IJ0N24rUAdGfp0u1IGTFstlxLr4LqpTQnHKdKZD/PzAwS
         lmAmiIc8wbB9i1cjQQ1OpavpIUOVP91umnbSfvWLR4yZ6sM4OeeTc8L05rDENv7pv8SR
         JI57a1TB3d6WSjJo45o+z8O4Dzc6BOkW3RE1a++ECimdcBraHo7QCgu4hJ+Z3p7rWrOX
         u2NhaN1YGo/KZxp9YE97Tt4hJTLo87+gRP19A49KFkdFs2L1/U1UWpHhDnd8n8SeVMow
         Vmn7ezsfwC85C++ygsOwr4+BPLfeWuUg+7aUHNdhBOhOgq4x40Z15E2nnbVWSUdag9ye
         L9jA==
X-Forwarded-Encrypted: i=1; AJvYcCXrkZpos9rBhaU3pI0PbBt1ZDH11BMiEFTA1W90LH5HvV+IZrEr9Wx8qt0PRTbgbjvBXKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwroBFmG4baY/nDnZp0DL5Jr2l1VAtjD2p4dZvF/MOpaT3QhsvO
	59ZmBVuilRhZe9O1xPGaKapwpvH6mKiwT+rJIgkZ5XDF2j973FEId4GO
X-Gm-Gg: ASbGncvS3cWFZuCY7oO6+bBmSYDXGN1n8D94nDNvYLEQjZe1hmZ73vNUnGTBDP4Tp5p
	fVVNQwgZrfSRDZwovS7aFa5gYB6+z5m70YxFxxVskjQlCRthhiTT7YbNpJNw2GaxOYBdPsUZQgr
	97b6rDhmCntDrJX+ogbckik8SEqHeWLNvqJy3z6VJzeUz2Fn7qhj3BnUtdjtYYXCbRtTlrsxZ8H
	7VYzuHRWLwXOwbPiYQYcijwuifO8JCOuXrvjgS2k+3ePCbZLfUOSPHutvA30P8jhyh5vTMdpxZX
	PyNZJjg3bt+804sAoMIIhCGa2rfjwvggKiKaCrT6OYAwrfTc/S4Mil4vVIbbpB4iCjQRxLpMvhx
	mDPXhvJeoEk/Bp1tfrhIC76WOexptTAgcJqRC1l4RNCdn4CzEuZBe4JrcczG9k/X6U5nsgvDh/p
	nBC2dEPw==
X-Google-Smtp-Source: AGHT+IEa1o17eoKThPPEuyeA7M5bW6iPm6eREoKK7m3x0sxdXPE1FGvFnc1U90Oo1q8SxcKXVOB4uw==
X-Received: by 2002:a05:693c:2288:b0:2a4:3592:cf60 with SMTP id 5a478bee46e88-2ab92d46d00mr1613349eec.4.1764760523491;
        Wed, 03 Dec 2025 03:15:23 -0800 (PST)
Received: from fedora ([2a01:7e03::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a96560986csm95192316eec.2.2025.12.03.03.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:15:23 -0800 (PST)
Date: Wed, 3 Dec 2025 19:15:12 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: slub: add barn_get_full_sheaf() and refine empty-main sheaf
 replacement
Message-ID: <dq67tbm6bbvm7opvuq5vwtjjrcnrponmhfv7xwnvpv6vp3u2lv@bkruq4dtx3rd>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
 <lvagftdnxgpyafafl2ish6x6phno6xstd6r3zxffs652lyxzyc@2pbngufu7wro>
 <aS_OrvHmgyhQzQIj@hyeyoo>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aS_OrvHmgyhQzQIj@hyeyoo>

On Wed, Dec 03, 2025 at 02:46:22PM +0900, Harry Yoo wrote:
> On Tue, Dec 02, 2025 at 05:00:08PM +0800, Hao Li wrote:
> > Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
> > the per-node barn without requiring an empty sheaf in exchange.
> > 
> > Use this helper in __pcs_replace_empty_main() to change how an empty main
> > per-CPU sheaf is handled:
> > 
> >   - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
> >     full sheaf from the barn via barn_get_full_sheaf(). On success, park
> >     the empty main sheaf in pcs->spare and install the full sheaf as the
> >     new pcs->main.
> > 
> >   - If pcs->spare already exists and has objects, keep the existing
> >     behavior of simply swapping pcs->main and pcs->spare.
> > 
> >   - Only when both pcs->main and pcs->spare are empty do we fall back to
> >     barn_replace_empty_sheaf() and trade the empty main sheaf into the
> >     barn in exchange for a full one.
> 
> Hi Hao,
> 
> Yeah this is a very subtle difference between __pcs_replace_full_main()
> and __pcs_replace_empty_main(), that the former installs the full main
> sheaf in pcs->spare, while the latter replaces the empty main sheaf with
> a full sheaf from the barn without populating pcs->spare.

Exactly.

> 
> Is it intentional, Vlastimil?
> 
> > This makes the empty-main path more symmetric with __pcs_replace_full_main(),
> > which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
> > empty sheaf from the barn. It also matches the documented design more closely:
> > 
> >   "When both percpu sheaves are found empty during an allocation, an empty
> >    sheaf may be replaced with a full one from the per-node barn."
> 
> I'm not convinced that this change is worthwhile by adding more code;
> you probably need to make a stronger argument for why it should be done.

Hi Harry,

Let me explain my intuition in more detail.

Previously, when pcs->main was empty and pcs->spare was NULL, we used
barn_replace_empty_sheaf() to trade the empty main sheaf into the barn
in exchange for a full one. As a result, pcs->main became full, but
pcs->spare remained NULL. Later, when frees filled pcs->main again,
__pcs_replace_full_main() had to call into the barn to obtain an empty
sheaf, because there was still no local spare to use.

With this patch, when pcs->main is empty and pcs->spare is NULL,
__pcs_replace_empty_main() instead uses barn_get_full_sheaf() to pull a
full sheaf from the barn while keeping the now‑empty main sheaf locally
as pcs->spare. The next time pcs->main becomes full,
__pcs_replace_full_main() can simply swap main and spare, with no barn
operations and no need to allocate a new empty sheaf.

In other words, although we still need one barn operation when main
first becomes empty in __pcs_replace_empty_main(), we avoid a future
barn operation on the subsequent “main full” path in
__pcs_replace_full_main.

Thanks.

> 
> > Signed-off-by: Hao Li <haoli.tcs@gmail.com>
> > ---
> 
> -- 
> Cheers,
> Harry / Hyeonggon
