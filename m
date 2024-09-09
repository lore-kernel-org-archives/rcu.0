Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8560132464
	for <rcu@vger.kernel.org>; Mon,  9 Sep 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897861; cv=none; b=QinRPPQsd+65w8ATkeJ60U0nevaKOtKVH7/3z7KeVbGxyPkZUSqjcVsgCiNQxeGZcq8V5ZMsxDGLD5+1RzgD5hQqtx1q9vp+IZeTrGkJhumqDXvREL7v+oqUTH0+oZ6F0pVnNw6W09RMIgzu5UTZbflA2/UCXVHRTFisLYWi5TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897861; c=relaxed/simple;
	bh=SfkXfubgiFx92+7wAeARbv+9+lO6N+ls1vXDEv4upOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Weh3jMrVceH/Wv3RW25SfEdp0TR5AwYwG3QMLkmyLwRUFT50H96ZkFEeeVUHOzMFH3d8oG6mg9VS2gK1A2lLIkUddQCtKCVlzZQmj1S39LA+wl4TqisoUIpVA0Bb6PQUuTJimE/wB75FEzjgtCbI79T9zXI4ONZUaUBVTjswbe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEpl45L0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEpl45L0"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-207332f7c17so9192985ad.2
        for <rcu@vger.kernel.org>; Mon, 09 Sep 2024 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725897859; x=1726502659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HIy0EXPmU4w2r9t2Tqb4i5dEPm1PsQzfMKsGrcWIWA8=;
        b=WEpl45L0itUFdPl0cxkIT0zVGdolwhd9w1Wk7BKBoh2mDRCGLi2PCGaYV8bu56eO+U
         S+TmH+Amc/ePIMgsZBq5/NOw7vKvfjmGYnxOm5lsBhfNOP9ZXZxABqFDE5Y89wLf99Rb
         iZuCzYD+dVg2YcprK8CAxrkMy8AJSY/pIUsnr7BCHloUhugslYjVOgJrtIDUgYgosZFm
         Ybms869aaW9QtAS88w2pzzvRqotFGRz5rb7aNKEoJjJzlpidXM/LL4qL8qMIAgtmXrit
         hRy4BAalMTL+jI1HVqKvFUDOpjle6brBGb5PS+2pUIxCpc1Kl1I2RAHOSivyaiboOLDI
         ZLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725897859; x=1726502659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIy0EXPmU4w2r9t2Tqb4i5dEPm1PsQzfMKsGrcWIWA8=;
        b=eG9q39XrlOe/xHWX8QUR6WEZ0sxNN+Hi2Uf9LsNauQqzr+USnshN8rXX2QAhGrLNQL
         VLAqxJzlJwV09me68MyjYUBvJNv+8e1y48/+MsAY1uMJbXMZkiuYbi8/gVMg/1FRsMvP
         jaA1zaCDAYi5f8kMxmZ4Xcjwn1j0KJ5Zh+73nP+T0j7rHjMTBis/siLnx8VBbiPPztRV
         KhZTPDDFYIMSATqE+HsM12u/EsU0T0lCvP4hYNb1UcrvDY5h+c06IUFleR8wGiRFGoYC
         Og7eXyhMALrUFS2C3yyvzx+LpdExxJ/2Cqy2/jhSTZjVzbx9PXNMGFsHcx9jqHNKQhM/
         ltSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcV3QXEQ3TDU0uBS5hycaYV7IYZZ8oEDXFks2/1ABnAUcjlSh7Ng7oTTvb9IjZXGKx34E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcDIVDoAEFcfVEdf5NLD3AoGTF1eGtgOajURcrhafvWLkIBCZP
	5FJ44Zokz8Ca31yYwWjQiZZn1MdLMnzj4UF1qEQ9dUT9+7AVgcUQ+qdvWYXSgsjH/ki4TE/1A53
	AoA==
X-Google-Smtp-Source: AGHT+IE4aiCLbBZ14WYzLNSaZH32wjFRVL8mk2TgwQJhNbZlhMrPltFxWEZ5OUqdU3rG1V+9P7yYcAioVaA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4c1:b0:205:826e:6a17 with SMTP id
 d9443c01a7336-206f0364078mr4697215ad.0.1725897859077; Mon, 09 Sep 2024
 09:04:19 -0700 (PDT)
Date: Mon, 9 Sep 2024 09:04:17 -0700
In-Reply-To: <c1d420ba-13de-48dd-abee-473988172d07@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZtUYZE6t3COCwvg0@yzhao56-desk.sh.intel.com> <87jzfutmfc.fsf@redhat.com>
 <Ztcrs2U8RrI3PCzM@google.com> <87frqgu2t0.fsf@redhat.com> <ZtfFss2OAGHcNrrV@yzhao56-desk.sh.intel.com>
 <ZthPzFnEsjvwDcH+@yzhao56-desk.sh.intel.com> <Ztj-IiEwL3hlRug2@google.com>
 <Ztl9NWCOupNfVaCA@yzhao56-desk.sh.intel.com> <Zt6H21nzCjr6wipM@yzhao56-desk.sh.intel.com>
 <c1d420ba-13de-48dd-abee-473988172d07@redhat.com>
Message-ID: <Zt8cgUASZCN6gP8H@google.com>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that support self-snoop
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>, 
	Yiwei Zhang <zzyiwei@google.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 09, 2024, Paolo Bonzini wrote:
> On 9/9/24 07:30, Yan Zhao wrote:
> > On Thu, Sep 05, 2024 at 05:43:17PM +0800, Yan Zhao wrote:
> > > On Wed, Sep 04, 2024 at 05:41:06PM -0700, Sean Christopherson wrote:
> > > > On Wed, Sep 04, 2024, Yan Zhao wrote:
> > > > > On Wed, Sep 04, 2024 at 10:28:02AM +0800, Yan Zhao wrote:
> > > > > > On Tue, Sep 03, 2024 at 06:20:27PM +0200, Vitaly Kuznetsov wrote:
> > > > > > > Sean Christopherson <seanjc@google.com> writes:
> > > > > > > 
> > > > > > > > On Mon, Sep 02, 2024, Vitaly Kuznetsov wrote:
> > > > > > > > > FWIW, I use QEMU-9.0 from the same C10S (qemu-kvm-9.0.0-7.el10.x86_64)
> > > > > > > > > but I don't think it matters in this case. My CPU is "Intel(R) Xeon(R)
> > > > > > > > > Silver 4410Y".
> > > > > > > > 
> > > > > > > > Has this been reproduced on any other hardware besides SPR?  I.e. did we stumble
> > > > > > > > on another hardware issue?
> > > > > > > 
> > > > > > > Very possible, as according to Yan Zhao this doesn't reproduce on at
> > > > > > > least "Coffee Lake-S". Let me try to grab some random hardware around
> > > > > > > and I'll be back with my observations.
> > > > > > 
> > > > > > Update some new findings from my side:
> > > > > > 
> > > > > > BAR 0 of bochs VGA (fb_map) is used for frame buffer, covering phys range
> > > > > > from 0xfd000000 to 0xfe000000.
> > > > > > 
> > > > > > On "Sapphire Rapids XCC":
> > > > > > 
> > > > > > 1. If KVM forces this fb_map range to be WC+IPAT, installer/gdm can launch
> > > > > >     correctly.
> > > > > >     i.e.
> > > > > >     if (gfn >= 0xfd000 && gfn < 0xfe000) {
> > > > > >     	return (MTRR_TYPE_WRCOMB << VMX_EPT_MT_EPTE_SHIFT) | VMX_EPT_IPAT_BIT;
> > > > > >     }
> > > > > >     return MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT;
> > > > > > 
> > > > > > 2. If KVM forces this fb_map range to be UC+IPAT, installer failes to show / gdm
> > > > > >     restarts endlessly. (though on Coffee Lake-S, installer/gdm can launch
> > > > > >     correctly in this case).
> > > > > > 
> > > > > > 3. On starting GDM, ttm_kmap_iter_linear_io_init() in guest is called to set
> > > > > >     this fb_map range as WC, with
> > > > > >     iosys_map_set_vaddr_iomem(&iter_io->dmap, ioremap_wc(mem->bus.offset, mem->size));
> > > > > > 
> > > > > >     However, during bochs_pci_probe()-->bochs_load()-->bochs_hw_init(), pfns for
> > > > > >     this fb_map has been reserved as uc- by ioremap().
> > > > > >     Then, the ioremap_wc() during starting GDM will only map guest PAT with UC-.
> > > > > > 
> > > > > >     So, with KVM setting WB (no IPAT) to this fb_map range, the effective
> > > > > >     memory type is UC- and installer/gdm restarts endlessly.
> > > > > > 
> > > > > > 4. If KVM sets WB (no IPAT) to this fb_map range, and changes guest bochs driver
> > > > > >     to call ioremap_wc() instead in bochs_hw_init(), gdm can launch correctly.
> > > > > >     (didn't verify the installer's case as I can't update the driver in that case).
> > > > > > 
> > > > > >     The reason is that the ioremap_wc() called during starting GDM will no longer
> > > > > >     meet conflict and can map guest PAT as WC.
> > > > 
> > > > Huh.  The upside of this is that it sounds like there's nothing broken with WC
> > > > or self-snoop.
> > > Considering a different perspective, the fb_map range is used as frame buffer
> > > (vram), with the guest writing to this range and the host reading from it.
> > > If the issue were related to self-snooping, we would expect the VNC window to
> > > display distorted data. However, the observed behavior is that the GDM window
> > > shows up correctly for a sec and restarts over and over.
> > > 
> > > So, do you think we can simply fix this issue by calling ioremap_wc() for the
> > > frame buffer/vram range in bochs driver, as is commonly done in other gpu
> > > drivers?
> > > 
> > > --- a/drivers/gpu/drm/tiny/bochs.c
> > > +++ b/drivers/gpu/drm/tiny/bochs.c
> > > @@ -261,7 +261,9 @@ static int bochs_hw_init(struct drm_device *dev)
> > >          if (pci_request_region(pdev, 0, "bochs-drm") != 0)
> > >                  DRM_WARN("Cannot request framebuffer, boot fb still active?\n");
> > > 
> > > -       bochs->fb_map = ioremap(addr, size);
> > > +       bochs->fb_map = ioremap_wc(addr, size);
> > >          if (bochs->fb_map == NULL) {
> > >                  DRM_ERROR("Cannot map framebuffer\n");
> > >                  return -ENOMEM;
> 
> While this is a fix for future kernels, it doesn't change the result for VMs
> already in existence.

I would prefer to bottom out on exactly whether or not the SPR/CLX behavior is
working as intended.  Maybe the ~8x slowdown is just a side effect of any Intel
multi-socket/node system, but I think we should get confirmation (inasmuch as
possible) that that is indeed the case.  E.g. if this is actually a bug in CLX+,
then the actions we need to take are different.

> I don't think there's an alternative to putting this behind a quirk.

This gets a bit weird, which is why I want to bottom out on whether or not CLX
and SPR are working as intended.  If non-coherent DMA is attached to the VM, then
even before this patch KVM would honor guest PAT.  I agree that we don't want to
break existing setups, but if CLX+SPR are working as intended, then this is
inarguably a bochs driver bug, and I would prefer to have the quirk explicitly
reference bochs-compatible devices, e.g. in the name and documentation, so that
userspace can disable the quirk by default and only leave it enabled if a bochs
device is being exposed to the guest.
