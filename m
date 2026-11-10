Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341994;
	b=5Bv4TXNfONBDcTcRFPAZEhSOYMzWv5Fcw5RvC7aKTYtH7xnteT4RNC7yTLCZs64XoV9o
	 PN5Vdfziw9oWSvRqDNXDJN++LiZV665+RD2+dpDMb60+3A//Bex91NnpwtcsH7y7Ej0Rv
	 QCdWWN5/628xQHUS58t0BfcNzybbxIbaeF0tuAHhTDiqls3KLGtH9TOi7GvPj9AetCUQC
	 lP3fQ2rPDivf1C+Q3drPmOo6ME0oA7ulnEIsNSdbBQQdkuqP3RFfYdhRenRTyDAuzs8Uw
	 FTkNsvc5Zz8kAvWjLNNQin044hsjDvTETXYEAXnw5JoxCN48thFFKHlQ1fmU70z99mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=sA+c0y1gtg/3n5Y+gL1JpZOKDFrA6DPjieeMuAQE0Nw=;
	b=niP/QmP+nzHqAtorVUrQ7CIZAt3mPUETdLIEDYtFkf3veb4Ydd6npBaqo2ga0ZLEPrjJ
	 piXi5x2UzG41Rl6mqaxfSBaUTyycGB3Q28Vcth/ICHZ230w2ntcGqxw6Z59cvbAX/M1wg
	 o7aJmHcqtDdFLE3GUtDVT71bBdBNmMw794AVmgxx3R13fqntRkiuzcQMRkeMaDEhGGy/I
	 jL9u3TrJu7B29TarFy+dwntGF/eG0PPjgt4l342uE+A+HplgnjWRmrAgcBpwT/KxDO0Ga
	 ssjyvfmTA7DlkZ2+f4d7JMI+R6Rhkp3iSuip/fjilUYgidjbgZ6nN4okwotTX7CawHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aP0X0iPt;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7990C606A326
	for <rcu@vger.kernel.org>; Tue, 10 Nov 2026 20:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7990C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aP0X0iPt
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdd77f53db5so1275210a12.2
        for <rcu@vger.kernel.org>; Tue, 10 Nov 2026 12:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794341994; x=1794946794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sA+c0y1gtg/3n5Y+gL1JpZOKDFrA6DPjieeMuAQE0Nw=;
        b=aP0X0iPtBrwNmhdMirAtRHYzTNScUoza0tcUi09jz2/7DAeJrq2GSp2y1EWXDpGpf6
         t+FoZ+jWY3xcdigvRR/oe2vxrnJcsD4GDSMCFvmqwGcoTb+b6x8Uoo4YcSTE5EbqIEy7
         nv2NJyNk6nyHPmxgiZ8MY0JHInxmm2+tw1OeAmv7GtSi2+neoYEKw5vzF4+z9DL+nZT4
         i0/2fS3s7Mz1VtKSFUpC/6CopEGZDoAtbP2KkTakh1JcZqkqFX5yRjhL7X74J2MxRE14
         zwXfLstdzwXLoaEI+e7hSKHqRsz4B2JSJWP+dLjpApkiNS/p5JPglF1s+krjd0gNRv8T
         2O4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794341994; x=1794946794;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sA+c0y1gtg/3n5Y+gL1JpZOKDFrA6DPjieeMuAQE0Nw=;
        b=mdDLInaTkMPs0CixY8IPb9AsLASkY2zpuT14XpeMfhWVWE9d72cD8spVWGqpMttJvm
         SGfKAm+t4WHFMGbsslyF56CvzTq8K8839imDm6VBbVd16JT5gTFlEjOVnpkqirhFAVRQ
         RzI8Ttjss2u9PeH1XG8sk0EGnuyQk6Kf0JioaJjfmHWYqYrddytudWZNGHUkx2/XgOpa
         6VV+xUvPCd9pCbRD2XCjno5G/r8ga5rrBQsM0/FoRnLVqaN2lqkyC2pXorgM5Kgpd0WG
         h9XDYE+Kwas9jq5+K4opxdYi+C1TFgf0mQU1keogWcwPvQDMzDXcGHcupbXXPwEMyWhk
         ks1Q==
X-Forwarded-Encrypted: i=1; AL+hErE4vA+yTdc49qGgdRIc8/VGfdUmFwkcK3h+ilR+3C7NTgVzIXWdd4b2gLVfI4CpVTkJYvI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ECBvTsKLH+YIJMb9TYsTEFCqFkBqbG3SBkZIs9y3qD+sY5F+f
	qlR3kMSvtiPyZntywalhl1ZE4zbPdHnkMv4osX4+0ZWM5pijdtRkLLuOzbIKKSoDK31JHXMVOB9
	y8AklhA==
X-Received: from pghf7.prod.google.com ([2002:a63:e307:0:b0:cd7:f985:396d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1446:b0:3e2:a849:64c5
 with SMTP id adf61e73a8af0-3f2fc99f9aamr241125637.19.1794341993521; Tue, 10
 Nov 2026 12:19:53 -0800 (PST)
Date: Tue, 10 Nov 2026 12:19:52 -0800
In-Reply-To: <20261105020104.2507083-7-dwmw2@infradead.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105020104.2507083-1-dwmw2@infradead.org> <20261105020104.2507083-7-dwmw2@infradead.org>
Message-ID: <avN8aJIHiX4xyTNO@seanjc-mac.roam.internal>
Subject: Re: [PATCH v2 06/20] KVM: x86: Request the guest TLB flush from record_steal_time()
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, rcu@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Durrant <paul@xen.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Fred Griffoul <fgriffo@amazon.co.uk>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Kunwu Chan <kunwu.chan@linux.dev>, 
	Kunwu Chan <kunwu.chan@gmail.com>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2026, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> record_steal_time() performs a TLB flush on the guest's behalf when the
> guest sets KVM_VCPU_FLUSH_TLB. With shadow paging,
> kvm_vcpu_flush_tlb_guest() ends up in mmu_sync_children(), which can
> reschedule via cond_resched_rwlock_write(). That is why the flush
> currently sits between a user_access_end() and a fresh
> user_access_begin(): it cannot be done while the guest page is mapped
> for access.
>=20
> Raise KVM_REQ_TLB_FLUSH_GUEST instead of flushing inline, and move the
> processing of KVM_REQ_STEAL_UPDATE ahead of where the TLB flush requests
> are serviced in vcpu_enter_guest() so that the flush still happens before
> the vCPU enters the guest. There is no requirement for it to complete any
> earlier than that.
>=20
> kvm_make_request() on the vCPU which is running is nothing more than a
> barrier and a set_bit(), so unlike the flush itself it can be done from
> any context =E2=80=94 which lets the surrounding access be simplified lat=
er.
>=20
> Note that the xchg() must stay where it is: it atomically consumes any
> KVM_VCPU_FLUSH_TLB which the guest has set, as required by commit
> b043138246a4 ("x86/KVM: Make sure KVM_VCPU_FLUSH_TLB flag is not missed")=
.
>=20
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260530061932.7849D1F00893@smtp.kern=
el.org
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kvm/x86.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6a1f0404f029..3c26c0eb9865 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2117,8 +2117,22 @@ static void record_steal_time(struct kvm_vcpu *vcp=
u)
> =20
>  		trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
>  				       st_preempted & KVM_VCPU_FLUSH_TLB);
> +		/*
> +		 * Request the flush instead of performing it inline. With
> +		 * shadow paging kvm_vcpu_flush_tlb_guest() can reschedule
> +		 * (via mmu_sync_children()), so it could not be called while
> +		 * the user access above was open. Requesting is just a bit
> +		 * set on the running vCPU, and the request is serviced
> +		 * before the vCPU enters the guest; nothing requires the
> +		 * flush to have completed any earlier than that.

Argh, I completely forgot about this.  It throws a big wrench in my plans t=
o fix
a mishandled TLB flush without using a deferred mechanism[1].  I really don=
't like
having to re-introduce deferred flags, but the diff is a lot smaller[2].  O=
n the
other hand, I still don't like the idea of delaying the MMU sync until the =
nested
VM-Exit.

I think I'll see how gross it is to do something like add a KVM_REQ_PV_TLB_=
FLUSH.

[1] https://lore.kernel.org/all/au0R41xbEJ_9W_9z@google.com
[2] https://lore.kernel.org/all/auDkX94UTjrLNmqp@google.com
