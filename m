Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B7B27056D;
	Wed, 10 Sep 2025 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489472; cv=none; b=RoK0qcFhCRUZH/SvgeDFb88s6kbS7Z7hTe7D2TtBSgmPNkcotAPdlXet/BWSOCfJtRrwT4eqqV2jpN3Vqis/rgYV7MMAnrg4Sax69SR8Xxz8hPEA06zD8mMmUQZ/TqxC4ftsMQTHnB0aVpAiE8+pYO3oB1KbsvvwRfMPxeHdbzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489472; c=relaxed/simple;
	bh=aLBtXmKx167i1YA63y7W4HmmeXF/5BMYUnmv/zS4pmY=;
	h=From:Date:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUQA2SCfxiy3RDNtyUYk7a7aDLCePRoZcKFOp1fDFEXZn5n9C6e++stBauYQctviunGKk3lxCjnrcOAgqfKLlzNm8gSlu3zGkA5c1rGPjqG/pV220pWTjx9M0Wt8tyfAsyacBs9Aaj6JJV42KMty1/S0V0/rNOLavS4VgE17QSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7W7ltzx; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7W7ltzx"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f6bb0a364so6860905e87.1;
        Wed, 10 Sep 2025 00:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757489469; x=1758094269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xFHJxuICj98Guwl4fVnasAXJJOBn+5zR++ozDmXM+Ds=;
        b=E7W7ltzxiL2cKj+i/H7a7JmfOCmggR88bpBlRwJ73XrNb3qY8NpgAPjlT9PC0J1+jI
         nNM5x63OhyTQDDcAI2AHOnI/VHO/wZ1Xc1JLXN4ISPW/OO0Xp6F17U40/DI+mUm9Ifg5
         qt5O/iYvK+D0e6Y9R0LGBwfj+WeP8KRhSFuFLXXfvovUB/DICST9xSR32AXwTE6P6+Xp
         ws1FFzXCqqr9u0GMbGCaNGZRbBE5Vpn3zvCDPVcl3DmSOSLaB9zvxZf1dg171Sd71l/R
         LnoyD0RYFlCzaKkXFG9uzDmRqITjPhGxwx54mq+fxl59LTkopk/sVHQ24mc6s181tBKZ
         nGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757489469; x=1758094269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFHJxuICj98Guwl4fVnasAXJJOBn+5zR++ozDmXM+Ds=;
        b=K7Id0nIt/AT8hoqHN0SCRVvDZU7Z398Ql2JaOpfnEzYgfd5X4AMs15tMV+fsYKuPNh
         81k78my/KG1oAbLp6hSnt6JyiKZjUUm7P0Ou9y7S2UOq1MzOZoHj3JyB4v+SzUhc5rXU
         hB36h/txmIodA+WLW3hrFHNHYZ8u154ESgYcbexC7Zup4C2GaXjoJJDaPN2/0zhYgTJe
         PRNxnddqCb8HwaxJmAz9val2oHheUkWpqy+l0nLHFKoCMHabTSc5iljqMpjHbPL+BLIe
         uX+8Z0Fc+IvdnzOQYztmqm4JlfssvMCoGxJTKbY3JIPR7048xuHfn8Qqt0syVgXbK7Dy
         4P1A==
X-Forwarded-Encrypted: i=1; AJvYcCUFLVlzHx3ZtIxVbkT9Tvj59Ca3xI07ROvN8q4cRtC8GbeiKI99NFBoq64/cV5DLIc1IV1x@vger.kernel.org, AJvYcCWmYqfbexwTCiXvgJQS+BzyFVsBeYeEdfOeKYftqOQm2VR6VCjd4H5xHvrbvr/Eluzju3BgDc/UfgErWvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+sSAjFTIe8cE0M+4PR8xOmW427sv5ru3NxBG2C69LAMZM4b0M
	kL7WepG6i1bEIqpWLs60fl+iwWr387bGsqVg02C3OIpaa23Z+YPPbDp3z+5XQKpb
X-Gm-Gg: ASbGncvxHF+IDmJ4YyU+Pzp6oFx8/6kzvGFRK80pX+AL3xwT7hRY1Es46+fgUdmHHEv
	q0tHuPM9p8utuq6DHtCiH9J3mKTXLTuNJvxiQgpZSI70WLLYgyDm85vnZF4EMleotxdE3SJMUU/
	CRnYfCEmBMwrGt9/qA9Hc6MXeDJ+jQeaiXWSWAkm/dkoCA4QsBH1edxcGMS/CUjRnIsJQyzq/l6
	l7zPp01G/V0hVAd831i/x3qZDv1kece/UGA7yTcUzHHWqFY1nAvK6zOBIKVQbpDDJ73NhdOeOW3
	5562anZ+i+UXFbMwfpPt9vrQn4OM24aL/IylG8Ga0WiF2zAR4ssrlNgkMMTnGHzOYeWUAxXs3XJ
	jiQWByM43STd9MdoFgZBAKFG/CslEosd2i86xb9wnHj7r2nbNMvt16auICOC7ms483BheF8A=
X-Google-Smtp-Source: AGHT+IEcsyTBCBDDV1Tw1uNbYG7FH9MeVABG6eLTqtCcX6osCxdSBBJoixssy7qrpruP7IVgjHC0lw==
X-Received: by 2002:a05:6512:6404:b0:55f:65a3:cfe7 with SMTP id 2adb3069b0e04-56262e1c134mr4873760e87.49.1757489468302;
        Wed, 10 Sep 2025 00:31:08 -0700 (PDT)
Received: from pc636 (host-95-203-28-174.mobileonline.telia.com. [95.203.28.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5695ac78c7asm874530e87.99.2025.09.10.00.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 00:31:07 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 10 Sep 2025 09:31:05 +0200
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v7 04/21] slab: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <aMEpOTLh8EX6DXYq@pc636>
References: <20250903-slub-percpu-caches-v7-0-71c114cdefef@suse.cz>
 <20250903-slub-percpu-caches-v7-4-71c114cdefef@suse.cz>
 <aL7FFpIMmXtzzSL1@pc638.lan>
 <6f8274da-a010-4bb3-b3d6-690481b5ace0@suse.cz>
 <aL_uhPtztx7Ef0T2@pc636>
 <772oyaa3j27tlklhpo6oqxsdtlvsg5goh2opzuig6xvgztgum4@scsoxrgtqm2f>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <772oyaa3j27tlklhpo6oqxsdtlvsg5goh2opzuig6xvgztgum4@scsoxrgtqm2f>

On Tue, Sep 09, 2025 at 10:35:15AM -0400, Liam R. Howlett wrote:
> * Uladzislau Rezki <urezki@gmail.com> [250909 05:08]:
> 
> ...
> 
> > 
> > > > - call_rcu() can be slow, therefore we do not use it in the kvfree_rcu().
> > > 
> > > If call_rcu() is called once per 32 kfree_rcu() filling up the rcu sheaf, is
> > > it still too slow?
> > >
> > You do not know where in a queue this callback lands, in the beginning,
> > in the end, etc. It is part of generic list which is processed one by
> > one. It can contain thousands of callbacks.
> 
> How does this differ from kvfree_rcu()?
> 
> Surely if you have enough calls to kvfree_rcu(), you will end up with a
> large list of frees before the end of a grace period?  Our placement in
> the freeing order would still be dependent on what else is using the
> infrastructure in the same grace period, right?
> 
In kfree_rcu() we use page blocks to carry pointers. Lists can be used
if there is a low memory condition so a page can not be allocated or
cache is empty. But this is not part of carr_rcu() track in any way.

Right regular call_rcu() puts callback into its own internal lists and
they are processed one by one during list iteration. In such lists you
can have hundred of thousand callback.

>
> How is kvfree_rcu() affected by rcu callback offloading to a specific
> cpu and rcu expedite?  Often these two features come into play for
> certain workloads which are of concern to us.
> 
We maintain a separate path. Offload is done after a grace period is
over. It is classic way. Historically all deferred freeing was one
call_rcu() per ptr.

> > 
> > If performance is not needed then it is not an issue. But in
> > kvfree_rcu() we do not use it, because of we want to offload
> > fast.
> 
> Today, I free things using call_rcu() and a custom callback so I would
> think stacking 32 together would make the list shorter, but latency
> would increase by waiting until there are 32.
> 
> If we wanted to flush the kvfree_rcu() list, is it done in the same way
> as the call_rcu() list, or is there a better way?
> 
For this case we have kvfree_rcu_barrier(). It is not same as call_rcu()
flushing.

--
Uladzislau Rezki
