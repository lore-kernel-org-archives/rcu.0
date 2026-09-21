Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838F0488225
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990178; cv=pass; b=dQPqjSp2Qi2mn2gMiorh0sWiwZfcDPFphIu0h4FjDiGJTM39Dt0aJOKlB4CpRb2H26iGXJ7PpSLENR9YZC2/45dSRe75aaIK+O9xHRbtHUsqQZX6f6zXOMKiT1o+ssrayBEya7AQfhqw5HENq3bKo8TATSbhlezJRhSR/LDhoJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990178; c=relaxed/simple;
	bh=ptOPvpl8Jn4/467WKDIfcKUlrqRNuCJaQOy7TpWYDfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELUCDiqBIWgYf3K5ALRx9loAoWlvTCycBNxPpnZJMlG7LHjFfvwGKxDC8JaZKJNry44Q3BKNx1G3GRFGGRw84ChltZxnJRhN50ISFYLBuveWNorGLD/KCO8XE460AN0pAcygh44ZzdRtoEb6RdMM+popaoU7ucWo0EnSidOnE4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6ageLli; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFjosavz; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6ageLli";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFjosavz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789990175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptOPvpl8Jn4/467WKDIfcKUlrqRNuCJaQOy7TpWYDfM=;
	b=O6ageLlihfDB6076/yHJyZKSoLL3nKRi/zQLTHfzt81mczUIQ9IS0tgvRJ1NlCjqBb4DoF
	GZrYoV3RbM1da3b462HvAx/mn3gZn/RrTsYJoZiIFO2UQUxFL/1TZPIy0U7ZqqGb/oJSYY
	phAiGePIBp/H+zTMNVR59vJJTguhh7A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-BkqZmUt0P5qR6dNFAbWXrQ-1; Mon, 21 Sep 2026 07:29:34 -0400
X-MC-Unique: BkqZmUt0P5qR6dNFAbWXrQ-1
X-Mimecast-MFC-AGG-ID: BkqZmUt0P5qR6dNFAbWXrQ_1789990173
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4870142fd5cso1489332f8f.0
        for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 04:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789990173; cv=none;
        d=google.com; s=arc-20260327;
        b=pL9JS2jR4xdTlh2Wu3J9Kd+EikXUPZM7500QZw6sn4FZGSZOAseFndkzv8NbcJg8Bh
         O4lAug3lSwYVl2rzdYhekd/rYJ/I6IF/s8VjE7U0/7rref5t9i/P8ZTPnCIk13cw7hJV
         kfVYiMYwqJuU3XEECTb0QEKQCoIVmqx898JR5rUESA3tnOa5uM1IJp671UFROERVv7FS
         lTAYwgRl/XpZb+qqEWewSksJ6pdApWt3zrOxQuyUjebLNGQ9k/7WRhaxUXuXBcGkYdqF
         FqtYzyU8Y7VtmGVlIFUIM1/DZIEStn21vGBv2uS6N9XwcXnw60zaE8pgm2IR6yMKKgmg
         S4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ptOPvpl8Jn4/467WKDIfcKUlrqRNuCJaQOy7TpWYDfM=;
        fh=Cm+1LusCUqP8nJHarRncNaxrdIHfn91QlEj385JVHAs=;
        b=P2h4oH0+aNkiS3mJkDHZpT7a1zXz5eUUSVgKvrlfZI22XDl+HBCD1YjirLvrnxIYyT
         Bqlf7ernKzb8ksOjRtcbfgp17PfUz/LgnQBsCaAwBVpeAAS9QpjL67nm8GtnBdeDAqyJ
         438+gVTzGB2MHcbDZUXSyRrCr4wt/hzjEd2WiynCDP3Fkbdyrbj6rXeOwu+kBWO2lldC
         olxUtY5IVeO+apMThuiM0oQH+20B28vzd5eUWafIHb/JJQ8e8/YYohCBOFbiW7mQFvz7
         UqHvTDYlocNvRSRvneLWGNBme8+Nojpou+YSRXcNcgwenLUShd0A1rWJXZxaCx/8YAbb
         JziA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789990173; x=1790594973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ptOPvpl8Jn4/467WKDIfcKUlrqRNuCJaQOy7TpWYDfM=;
        b=hFjosavzTEBg7sS+/amQKm0DVwQIeND1Et6uVLHGgp9oztjbPFCj1GSVjXpTtW1o4K
         Bc/WtO6t3w0BAV929yBDSAi710gt9i8vIG6G4IyZ6GylRBVB41jc975KGZ4C1vu8jtTJ
         x7xcrV9Z/Uk9xBkxBfaUqamjFEOwqtWIVJnzLrJGEKAvBb06h8yPiHXwvPyE6czoy7I2
         +8i/fivrjJ4mfrJsjj/GSjzW25mhmbFvGSLW+leI/NDqeBUQcrHQxaHhM2koGsHWO/cA
         SqniDp40toI3F8H6TS7Y1ucl7zgJL2l4gWnJOBTOA0JIIEQ+e05bwbUp/oqKz+wPpNep
         JPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789990173; x=1790594973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ptOPvpl8Jn4/467WKDIfcKUlrqRNuCJaQOy7TpWYDfM=;
        b=zpj3bBVZb+fjjrLAbm22FMVRV6CiInVDMxTlkARzEB6FeU/tnp4UwL/zsAxYTIeCLq
         OhbBgODa44s2ikBdYEBdbi7i1nsPQa/9CS61sdc8v43ECqzHX/tFAVIvbKh0ug7wbhKC
         nFEpNXJcbuFNljKmIfHF9A9r0oVXmCkiZ1NV3cpSjhwy0WNWA9Txy9BqHJyuwr416yue
         mIs0+y4/dt/apT74g653KMfc7DqBMlOwU012KXSmSzXNLp01HKeAR9nVwvJqJT7fol+X
         nTtdALditWjyOO27bECsIW5NkOyxNiY/dLTENopmBpJzSEOHniLyqFB3y6eREKOVAzuR
         LXNg==
X-Forwarded-Encrypted: i=1; AKwUvByevqnwd28zTp0E9sDhkhR8SLFknU31eRFQLDuULMGSG0BONDCNznO3tNIk6cj7NSzI3rA=@vger.kernel.org
X-Gm-Message-State: AFuF++kQYiHj745A6Mvhzq+qNYRVKXFd/tQeH/g8P1Dd4ZdT4eKOS70w
	Tws7XlKseNZTkLCscSrFtaWqhN3aFXdK/9g/OWmBHDkvzjOcEgw5O/uNjabTnC+aaCPnAKNuk/u
	FOgmznevbJ54U8QE56KJf4PkX9kz2PZPyLnHLiGoMfD3kBIQ30wdDAGBnBc7MQEgMrbMC9oTnHC
	hvkWKtlf9vTKAP2s5Cw2sSBE1eHc1Y
X-Gm-Gg: AYBFou0FEsqYMdtmk32rUtYPtBThfn5DToL7LBJnacUa9VkajV1BAbq7dqTLKnvThAx
	p+ln3vPMIqaXknGY8X1yj8VvstgOym4n6PgvwRF9T/ZRbHSaEo3VZFsZ+tAW2KpAM/TOp8ByAXC
	/pY4AydOChbeVSAfRkFdv6TWGt34hgReGRMBigz2849pjZpcmdhx0P74mp5Nx5v1/N+c4ExFEhu
	Ir27uN4famrL5WvIDXuTTbosjr43oYIkihgSq2gn5aMZSiQ9OMX15wYSmIWig==
X-Received: by 2002:a05:6000:491e:b0:487:84:96d7 with SMTP id ffacd0b85a97d-4871e373189mr14673934f8f.53.1789990172848;
        Mon, 21 Sep 2026 04:29:32 -0700 (PDT)
X-Received: by 2002:a05:6000:491e:b0:487:84:96d7 with SMTP id
 ffacd0b85a97d-4871e373189mr14673903f8f.53.1789990172510; Mon, 21 Sep 2026
 04:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <272c0fdf9e5eb9a1caf6a5c0bf674e3c006ac2ea.camel@infradead.org> <20260921112131.274-1-hdanton@sina.com>
In-Reply-To: <20260921112131.274-1-hdanton@sina.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Sep 2026 13:29:21 +0200
X-Gm-Features: AcwNN1Xi_H7uo3XvFAj5sLWKjk7Urm5G8ShkD2xSWIid9H62cmytfHb-xU95uPA
Message-ID: <CABgObfYZKfSV=Ykmjkey+t1pA4rEEk8=a-VMho4=A0=xNLmKcA@mail.gmail.com>
Subject: Re: [PATCH 01/17] KVM: pfncache: Use atomic SRCU for readers instead
 of a rwlock
To: Hillf Danton <hdanton@sina.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 1:21=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Mon, 21 Sep 2026 11:54:36 +0200 David Woodhouse wrote:
> > On Mon, 2026-09-21 at 09:42 +0800, Hillf Danton wrote:
> > > On Sun, 20 Sep 2026 21:49:29 +0100 David Woodhouse wrote:
> > > >
> > > > Replace the per-cache rwlock with a dedicated per-VM atomic SRCU
> > > > domain (kvm->gpc_srcu) for the read side. Readers now run under
> > > > srcu_read_lock_atomic() alone =E2=80=94 preemption disabled and non=
-blocking
> > > > enforced, which every GPC read-side section already satisfied as a
> > > > former rwlock critical section. It works in any context
> > > > (including hardirq and sched-out paths) and never fails or spins,
> > > > eliminating the
> > > > read_trylock() contortions in the atomic paths, the double-lock dan=
ce
> > > > with the lockdep subclass hack in the runstate update, and the
> > > > PREEMPT_RT problems inherent to taking an rwlock in those contexts.
> > > > In particular, kvm_xen_set_evtchn_fast() is called from hardirq
> > > > context (timer callback, kvm_arch_set_irq_inatomic()), where taking
> > > > gpc->lock is a sleeping-lock-in-atomic-context bug on PREEMPT_RT.
> > >
> > > Given the preempt_disable() in srcu_read_lock_atomic(), as PREEMPT_RT
> > > has no way of handling preempt_disable(), you need to add another
> > > version of srcu_read_lock_atomic() with preempt_disable() replaced wi=
th
> > > something like rcu_read_lock().
> >
> > Hm? What's wrong with preempt_disable()? It works OK, but is generally
>
> How is preempt_disable() handled by RT?

It disables preemption. :)

The difference is that *spinlocks* (by virtue of becoming sleeping
locks) do not disable it, but the low-level primitives preempt_disable
and get_cpu do not change their behavior.

Older PREEMPT_RT patches had get_cpu_light() which did
migrate_disable() instead of preempt_disable(), but then
migrate_disable() was deprecated.

Paolo

