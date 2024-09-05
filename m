Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9505B4A2D
	for <rcu@vger.kernel.org>; Thu,  5 Sep 2024 00:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496870; cv=none; b=TpTBm6wz5WlXjRvxcNXrDXV33oAp7wrCwl3ndD9tqDX2D9YQU/MvZ4YUXq3QvU6p+BLKIU+tRmKlA7C3aZcLZbp07kgOq/ggBY2CafImsuam3DBhwLEX70su7KTmcqQzTJa0+IE+5jmjMI2chHENNk8PwuRyMRrWhU9TSmsARRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496870; c=relaxed/simple;
	bh=ilmYsVNMSu1GsaTnBQQLMF9CW8oHkr1VBh9h+1iRw54=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tScG5W/ROrwnWjAPw1i8q1hhbbknble/ydKsDix7Ii+K1tQL2c3E2o9dF3rXP4m8uyWHisdGRL+GoFq3zV/m+3yeyyIbZcvxRSg8QDV0NyE2cQ1uiCi1U+HVELpWhFUFBUcRn0/l54zL90iyB1OO/7cE0TmgpGQ9xROViS7QlWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T3qMAODE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T3qMAODE"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2d877d2ad3fso162251a91.2
        for <rcu@vger.kernel.org>; Wed, 04 Sep 2024 17:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725496868; x=1726101668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FMry0JvYndcQLUhZCsv77Q7XrtFl137enu18o8wNcxA=;
        b=T3qMAODEzPh3VJaFz6kWHjF51AIzl0QCso8Jd6jeVyrU9TvfkfprlsyGjveaMKQ2yW
         DFIIjcFuHOkOc3hGeqv880xlQzYeDL9y0TRoFPve+cgOy3F03aYszLA9pDhPbOduX5OQ
         BYuCoEZ3X4xNLJb1wsrn1GwgnSe4tpmWjj4kZ2KvoN8g6tvBKVxXQYa77MmxzCePR+KY
         x57AvJjV+wUqSFwrg11Z4fa+rxziCjhf4ryC5HGPSMAxFdw6myuEOzwj9UjO6UK0iELE
         MLZ+SrotrXdlzxn9DwHzsGiSgVprcZPRW7r+FFAn7xJXm9HsRhgeyYlDGG4U0Gpr84tZ
         U9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725496868; x=1726101668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMry0JvYndcQLUhZCsv77Q7XrtFl137enu18o8wNcxA=;
        b=vpSAkxqgt8p51/W0ikVZfowBtN+1fpjtAdhZgEqSzuSPm3okDSvFRZ8jmLfQQ/RFsd
         G+lPznhRkwrAd44fKJaFWidGTnzSsOARdkTwBgCJ2Wbbvof0cG4VJPnhcvS+lF15GTpc
         Eg/0f7he+ZgsUpBjUrYv6PeQ8y/ns0WuzqJKSD/QtyvOZz2Sepk4PPbsum9hn59Ly4m2
         83oNWX0ZqGQOcEaugl9IBfJFaBBA3+YF1q9dDCwxytU6rAoxDZpTyV9YfigniaYVz5nW
         rI7Kf10ISGjV9yHS/9/iwrhDQHBoYm8osEDvCMQh4BDkNZkLBMpWh6jQULxtfZG702ab
         2hWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWksPnL+zvxH5gCd++DjIj/sSveJwHZiZByuccEPEhg325nT63SMl7988W5ZfkjT6aLxvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmN8A7rhlKZvpa7N+wiw1lpdfhl1qoKZio1vxrJHFGmZNv+3gp
	RfRnPHguzk4sw1ZDSOqrqKNO0fZeqvqHjZVmYhrv6dqd2AFzOelctWf1zWN+9K+3AzxT7IKC+Gx
	/eg==
X-Google-Smtp-Source: AGHT+IGlZUDSltIWI5UCXXys/3zPyqqZ9mhtDPBCcfk9UYyIfXH9PVSS/4d7gViv59YrODYrF2bMsarezqI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c504:b0:2d8:d736:c355 with SMTP id
 98e67ed59e1d1-2d8d736d3a0mr94302a91.7.1725496867734; Wed, 04 Sep 2024
 17:41:07 -0700 (PDT)
Date: Wed, 4 Sep 2024 17:41:06 -0700
In-Reply-To: <ZthPzFnEsjvwDcH+@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309010929.1403984-6-seanjc@google.com> <877cbyuzdn.fsf@redhat.com>
 <vuwlkftomgsnzsywjyxw6rcnycg3bve3o53svvxg3vd6xpok7o@k4ktmx5tqtmz>
 <871q26unq8.fsf@redhat.com> <ZtUYZE6t3COCwvg0@yzhao56-desk.sh.intel.com>
 <87jzfutmfc.fsf@redhat.com> <Ztcrs2U8RrI3PCzM@google.com> <87frqgu2t0.fsf@redhat.com>
 <ZtfFss2OAGHcNrrV@yzhao56-desk.sh.intel.com> <ZthPzFnEsjvwDcH+@yzhao56-desk.sh.intel.com>
Message-ID: <Ztj-IiEwL3hlRug2@google.com>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that support self-snoop
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>, 
	Yiwei Zhang <zzyiwei@google.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 04, 2024, Yan Zhao wrote:
> On Wed, Sep 04, 2024 at 10:28:02AM +0800, Yan Zhao wrote:
> > On Tue, Sep 03, 2024 at 06:20:27PM +0200, Vitaly Kuznetsov wrote:
> > > Sean Christopherson <seanjc@google.com> writes:
> > > 
> > > > On Mon, Sep 02, 2024, Vitaly Kuznetsov wrote:
> > > >> FWIW, I use QEMU-9.0 from the same C10S (qemu-kvm-9.0.0-7.el10.x86_64)
> > > >> but I don't think it matters in this case. My CPU is "Intel(R) Xeon(R)
> > > >> Silver 4410Y".
> > > >
> > > > Has this been reproduced on any other hardware besides SPR?  I.e. did we stumble
> > > > on another hardware issue?
> > > 
> > > Very possible, as according to Yan Zhao this doesn't reproduce on at
> > > least "Coffee Lake-S". Let me try to grab some random hardware around
> > > and I'll be back with my observations.
> > 
> > Update some new findings from my side:
> > 
> > BAR 0 of bochs VGA (fb_map) is used for frame buffer, covering phys range
> > from 0xfd000000 to 0xfe000000.
> > 
> > On "Sapphire Rapids XCC":
> > 
> > 1. If KVM forces this fb_map range to be WC+IPAT, installer/gdm can launch
> >    correctly. 
> >    i.e.
> >    if (gfn >= 0xfd000 && gfn < 0xfe000) {
> >    	return (MTRR_TYPE_WRCOMB << VMX_EPT_MT_EPTE_SHIFT) | VMX_EPT_IPAT_BIT;
> >    }
> >    return MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT;
> > 
> > 2. If KVM forces this fb_map range to be UC+IPAT, installer failes to show / gdm
> >    restarts endlessly. (though on Coffee Lake-S, installer/gdm can launch
> >    correctly in this case).
> > 
> > 3. On starting GDM, ttm_kmap_iter_linear_io_init() in guest is called to set
> >    this fb_map range as WC, with
> >    iosys_map_set_vaddr_iomem(&iter_io->dmap, ioremap_wc(mem->bus.offset, mem->size));
> > 
> >    However, during bochs_pci_probe()-->bochs_load()-->bochs_hw_init(), pfns for
> >    this fb_map has been reserved as uc- by ioremap().
> >    Then, the ioremap_wc() during starting GDM will only map guest PAT with UC-.
> > 
> >    So, with KVM setting WB (no IPAT) to this fb_map range, the effective
> >    memory type is UC- and installer/gdm restarts endlessly.
> > 
> > 4. If KVM sets WB (no IPAT) to this fb_map range, and changes guest bochs driver
> >    to call ioremap_wc() instead in bochs_hw_init(), gdm can launch correctly.
> >    (didn't verify the installer's case as I can't update the driver in that case).
> > 
> >    The reason is that the ioremap_wc() called during starting GDM will no longer
> >    meet conflict and can map guest PAT as WC.

Huh.  The upside of this is that it sounds like there's nothing broken with WC
or self-snoop.

> > WIP to find out why effective UC in fb_map range will make gdm to restart
> > endlessly.
> Not sure whether it's simply because UC is too slow.
> 
> T=Test execution time of a selftest in which guest writes to a GPA for
>   0x1000000UL times
> 
>               | Sapphire Rapids XCC  | Coffee Lake-S
> --------------|----------------------|-----------------
> KVM UC+IPAT   |    T=0m4.530s        |  T=0m0.622s

Woah.  Have you tried testing MOVDIR64 and/or WT?  E.g. to see if the problem is
with UC specifically, or if it occurs with any accesses that immediately write
through to main memory.

> --------------|----------------------|-----------------
> KVM WC+IPAT   |    T=0m0.149s        |  T=0m0.176s
> --------------|----------------------|-----------------
> KVM WB+IPAT   |    T=0m0.148s        |  T=0m0.148s
> ------------------------------------------------------
