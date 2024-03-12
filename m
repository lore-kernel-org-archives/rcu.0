Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172221386BA
	for <rcu@vger.kernel.org>; Tue, 12 Mar 2024 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263286; cv=none; b=iC/bHCgvbgwLWUCikCiFF2GPGEZ8O44kjHtddYBz9B7ZYDW3QPiByPi89UEshkZY3SscJb722VOE2ZJGv4nBo7O/LHwmr6Eag4NPHqeyt/xYuWuuRmFjISzPCH4RM8IORiTSzmCSsXSNHVHlHzV92uWLujiDQ4Fmlft5QvmRNxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263286; c=relaxed/simple;
	bh=LCt3WWvGn4P8WKRrmZ370zHM2Olntl8aKMiYWPrEOpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OqOGpkyafyihWIXcaOp6wj0Q0K8mkaT01sddqBwk/dhonxXnrCRxvJ1rFPbw90sto76ftikn5pNthwe+qovBiA7dIartPd5yNKOsUZiSlDMn0jjrqUG9u9cfFuxGFGOXrL8WOcVe6QFH6PIG+/jRCEKVvdduRKdAmZPOWcLrr3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mdd623ZJ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mdd623ZJ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5c670f70a37so5220265a12.2
        for <rcu@vger.kernel.org>; Tue, 12 Mar 2024 10:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710263284; x=1710868084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WE8e1Ziotl3mZ18Tc3buOFiIUh2+sqQFXIcFrXQVlYE=;
        b=Mdd623ZJ8ozdBoWFRe/vQqSnLlmzGLbDodzEDOBX19UTcrKd+OgXfShY7GlxGT4RMv
         +sFVjEy6MV4eiYg9SzXgmTdgoBYEY30sO6NXqm+DlNr+vjC1C5koOVqSPQD2DfmHLZTP
         IQ03Af9ObWtSr6X3SiHkvLlYOhJVPVUESqOMzTuxsj8+RHXN5hOPeuFInzIv2S1rdwMO
         KH7JIv3ccdGVKTwnCsvJRjcyq2YnQSNdbae46eDDWMumtOjJwOxavTsfoSGRMqZKJwHt
         lwcihTYhkb3CPfl0MXCt5Aapw6+wIC8bj730pa5gaJYvC76M9EDncMO3u/gsxfkcXuWF
         V5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263284; x=1710868084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WE8e1Ziotl3mZ18Tc3buOFiIUh2+sqQFXIcFrXQVlYE=;
        b=wroMJYqp0yc4/+4BiPbOJ8CAHImhJZpmmms0HQShSRvrbZ9+klfn0/rNjiSN2nH8V3
         QVsRWJucKDBm60n2UJ/YSaCVq30XAv9sZGo/3YNCTFKPMutzIi6qGk87cE3Lsj+PSOYb
         Rqpe/67RPXC+/H41yUtZqqPNpf+Ts7DyqkbxMyisUMI81wDCq/mP/75+vvvll+mDaWfZ
         vdR2mYCKm0vM11Ono1mcHWXFo25Wx/jQDkP4DhPjWS7H/3QztC665rfk2uMwNqKSgCO8
         TwzHbnFp9k+KeE7erYKkgqUjlxJPCeFewW69rPrGK2+/d4GA4rB7XYmTrDhGaiGhYLTJ
         DEDA==
X-Forwarded-Encrypted: i=1; AJvYcCWSgFf8wANkWu4p8ziXLWyrJ5zi0+LqL/joegFx53xxKU9EY5cCpADn4UiRoV4E8JheeZKPWRVnFGnpat5k/9JLVUZ9
X-Gm-Message-State: AOJu0Yy5TNonowhWSfLi4kAmFbdUmgiQfYuPVIW39PYDuK0qBr0rCVrP
	xSgauN1/qwNR+Due4bMHMX7Y8d4fah2NsKfIt41bJMO8AvKBQ6TdCENgzvm0QnRKffrPGhcGj1d
	LQA==
X-Google-Smtp-Source: AGHT+IE5t8MewLarAvjjhbmUaRutQbVD7rwK9cE51AMPD3wv7USN8MStB1z1W1pob50IpkZGEhvbJJKimsM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:e02:0:b0:5dc:6130:a914 with SMTP id
 d2-20020a630e02000000b005dc6130a914mr26681pgl.7.1710263284174; Tue, 12 Mar
 2024 10:08:04 -0700 (PDT)
Date: Tue, 12 Mar 2024 10:08:02 -0700
In-Reply-To: <5ee34382-b45b-2069-ea33-ef58acacaa79@oracle.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309010929.1403984-1-seanjc@google.com> <20240309010929.1403984-2-seanjc@google.com>
 <5ee34382-b45b-2069-ea33-ef58acacaa79@oracle.com>
Message-ID: <ZfCL8mCmmEx5wGwv@google.com>
Subject: Re: [PATCH 1/5] KVM: x86: Remove VMX support for virtualizing guest
 MTRR memtypes
From: Sean Christopherson <seanjc@google.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, kvm@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Yiwei Zhang <zzyiwei@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 11, 2024, Dongli Zhang wrote:
> 
> 
> On 3/8/24 17:09, Sean Christopherson wrote:
> > Remove KVM's support for virtualizing guest MTRR memtypes, as full MTRR
> > adds no value, negatively impacts guest performance, and is a maintenance
> > burden due to it's complexity and oddities.
> > 
> > KVM's approach to virtualizating MTRRs make no sense, at all.  KVM *only*
> > honors guest MTRR memtypes if EPT is enabled *and* the guest has a device
> > that may perform non-coherent DMA access.  From a hardware virtualization
> > perspective of guest MTRRs, there is _nothing_ special about EPT.  Legacy
> > shadowing paging doesn't magically account for guest MTRRs, nor does NPT.
> 
> [snip]
> 
> >  
> > -bool __kvm_mmu_honors_guest_mtrrs(bool vm_has_noncoherent_dma)
> > +bool kvm_mmu_may_ignore_guest_pat(void)
> >  {
> >  	/*
> > -	 * If host MTRRs are ignored (shadow_memtype_mask is non-zero), and the
> > -	 * VM has non-coherent DMA (DMA doesn't snoop CPU caches), KVM's ABI is
> > -	 * to honor the memtype from the guest's MTRRs so that guest accesses
> > -	 * to memory that is DMA'd aren't cached against the guest's wishes.
> > -	 *
> > -	 * Note, KVM may still ultimately ignore guest MTRRs for certain PFNs,
> > -	 * e.g. KVM will force UC memtype for host MMIO.
> > +	 * When EPT is enabled (shadow_memtype_mask is non-zero), and the VM
> > +	 * has non-coherent DMA (DMA doesn't snoop CPU caches), KVM's ABI is to
> > +	 * honor the memtype from the guest's PAT so that guest accesses to
> > +	 * memory that is DMA'd aren't cached against the guest's wishes.  As a
> > +	 * result, KVM _may_ ignore guest PAT, whereas without non-coherent DMA,
> > +	 * KVM _always_ ignores guest PAT (when EPT is enabled).
> >  	 */
> > -	return vm_has_noncoherent_dma && shadow_memtype_mask;
> > +	return shadow_memtype_mask;
> >  }
> >  
> 
> Any special reason to use the naming 'may_ignore_guest_pat', but not
> 'may_honor_guest_pat'?

Because which (after this series) is would either be misleading or outright wrong.
If KVM returns true from the helper based solely on shadow_memtype_mask, then it's
misleading because KVM will *always* honors guest PAT for such CPUs.  I.e. that
name would yield this misleading statement.

  If the CPU supports self-snoop, KVM may honor guest PAT.

If KVM returns true iff self-snoop is NOT available (as proposed in this series),
then it's outright wrong as KVM would return false, i.e. would make this incorrect
statement:

  If the CPU supports self-snoop, KVM never honors guest PAT.

As saying that KVM may not or cannot do something is saying that KVM will never
do that thing.

And because the EPT flag is "ignore guest PAT", not "honor guest PAT", but that's
as much coincidence as it is anything else.

> Since it is also controlled by other cases, e.g., kvm_arch_has_noncoherent_dma()
> at vmx_get_mt_mask(), it can be 'may_honor_guest_pat' too?
> 
> Therefore, why not directly use 'shadow_memtype_mask' (without the API), or some
> naming like "ept_enabled_for_hardware".

Again, after this series, KVM will *always* honor guest PAT for CPUs with self-snoop,
i.e. KVM will *never* ignore guest PAT.  But for CPUs without self-snoop (or with
errata), KVM conditionally honors/ignores guest PAT.

> Even with the code from PATCH 5/5, we still have high chance that VM has
> non-coherent DMA?

I don't follow.  On CPUs with self-snoop, whether or not the VM has non-coherent
DMA (from VFIO!) is irrelevant.  If the CPU has self-snoop, then KVM can safely
honor guest PAT at all times.

>  bool kvm_mmu_may_ignore_guest_pat(void)
>  {
>  	/*
> -	 * When EPT is enabled (shadow_memtype_mask is non-zero), and the VM
> +	 * When EPT is enabled (shadow_memtype_mask is non-zero), the CPU does
> +	 * not support self-snoop (or is affected by an erratum), and the VM
>  	 * has non-coherent DMA (DMA doesn't snoop CPU caches), KVM's ABI is to
>  	 * honor the memtype from the guest's PAT so that guest accesses to
>  	 * memory that is DMA'd aren't cached against the guest's wishes.  As a
>  	 * result, KVM _may_ ignore guest PAT, whereas without non-coherent DMA,
> -	 * KVM _always_ ignores guest PAT (when EPT is enabled).
> +	 * KVM _always_ ignores or honors guest PAT, i.e. doesn't toggle SPTE
> +	 * bits in response to non-coherent device (un)registration.
>  	 */
> -	return shadow_memtype_mask;
> +	return !static_cpu_has(X86_FEATURE_SELFSNOOP) && shadow_memtype_mask;
>  }
> 
> 
> Thank you very much!
> 
> Dongli Zhang
