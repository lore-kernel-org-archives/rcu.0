Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9C1D3560
	for <rcu@vger.kernel.org>; Mon,  7 Oct 2024 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308302; cv=none; b=EikRbCqmqi3DDecJg4N9uIGY/nnVixo8KzIdN3h7bu54ddROuMFrs2y/ltDoQoKnwXRlWXjtIYKbswd5Tv03Jazo/rsX7DR7r8Aq+KhGOmfL8iqtA+ncEYC0nKZGZOuuRD8/r2+afDWMlj4LXRO6xQLiKK9ikm0c1aAyy73Gdog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308302; c=relaxed/simple;
	bh=yVdeGgNTfeFuIEVPc7u0AK0zINUin07XGVxlqUetaSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DGLTGkPX9MOCPXwZCfOJTdUQenb8tmy9Wwl0TtY0GDUHouX5UVYmI+npf/XabzdDB2fcwuWNAmLQBVRVCoBXfdNtTuzdT5GYYZ+v1TGicQUzlP+n6428v/56JUSaz6oFYGCxdvjV7DSew3CoiZ8r+vB/bBk0LbCsDJEuv5MzJuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hdK03pHB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdK03pHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728308299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5DPNZskkiUAq4LS5OFpU8MIweVBZO51RYIR24GV8o8=;
	b=hdK03pHBgUv71YXK4AYHt02n1CH+DiY9M9HdpLFOzKlb+wZvnhhg6++u3cj9KC85sjAX3+
	UfzDri+Vpc/zwnTB8fIVDicEhYBshtXViFgYqOoiSIXcLVunIOvbUDqHnnQKjzJQReyhj9
	TIteoPvxBl0F9wJYNFMT3CecSaiQ9GY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-VsF-aASbPLmtpbBJ7fZQ6g-1; Mon, 07 Oct 2024 09:38:18 -0400
X-MC-Unique: VsF-aASbPLmtpbBJ7fZQ6g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42caf073db8so39782875e9.3
        for <rcu@vger.kernel.org>; Mon, 07 Oct 2024 06:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728308297; x=1728913097;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5DPNZskkiUAq4LS5OFpU8MIweVBZO51RYIR24GV8o8=;
        b=IYiB1Wkb6Bs4BzIaoSFbl2VQc0K4I69GHaoqhntF5wB2jfKG/+RaECDKedPxKIiQms
         TB5Vfez8FrI0lDdjc1uxt+ed5Yzw792RfuX/1xqaIGUlFioBegkE0LEan8xlyOJFQpIm
         H4M9Hn5lBN3RRxeEx8eiZhMeh/OU7MLAh9N88rHEpeVBi+Gxjcp8h3fmQanfwIke69Hc
         H/ZvOZS4nVrnfJHHdpWIbzOMxWARnix5vaDqv/e6CxqtRE+v2qmhDRsER+X3/1Mwcq7u
         3lbBiWI53WfDxmpyAZqJ2nsfAfusGOWUBA7j0koICjuZ7ZImn6SwJrceyaPRBvWm0m0i
         V0Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVEJ3Kjsi+uZl0rnMkQdyQRi5kYnZyfM3b1SPSGOzX+rLL8qqQPrlgoPsCCt2dFdDdnO9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFi84iPWz64CqF1MnhLNpK8NPSl06KU1bv92ZeKfq5xqF6itU9
	K85+QFz2IRTfBfy6FhXpI1MuZWCnVs0akq3JY7iXBSt7TeTkYEu/i+zN4P2y6Dp+SbaHP6kWCyi
	luhdoLHsBKluRCFuyHnOzGfAYzGll7IpUBAQBPEc1aBD0zmOhgw==
X-Received: by 2002:adf:ea8c:0:b0:374:c287:929b with SMTP id ffacd0b85a97d-37d0e6bb291mr6937290f8f.4.1728308296948;
        Mon, 07 Oct 2024 06:38:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0TwOIoXGhtncVqqSCdfhnggtMr8A9YmeYV2RL1PX3MgPcnG86Oq8dGEM8Qg3X1MoztO3Yqw==
X-Received: by 2002:adf:ea8c:0:b0:374:c287:929b with SMTP id ffacd0b85a97d-37d0e6bb291mr6937277f8f.4.1728308296459;
        Mon, 07 Oct 2024 06:38:16 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f75bsm5766858f8f.23.2024.10.07.06.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:38:16 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, Yiwei
 Zhang <zzyiwei@google.com>, Lai Jiangshan <jiangshanlai@gmail.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Linux kernel regressions list
 <regressions@lists.linux.dev>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that
 support self-snoop
In-Reply-To: <df3c6560-dd37-4ec2-9b7e-1ad4c3ceba07@leemhuis.info>
References: <20240309010929.1403984-1-seanjc@google.com>
 <20240309010929.1403984-6-seanjc@google.com> <877cbyuzdn.fsf@redhat.com>
 <df3c6560-dd37-4ec2-9b7e-1ad4c3ceba07@leemhuis.info>
Date: Mon, 07 Oct 2024 15:38:15 +0200
Message-ID: <87iku4ghiw.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Linux regression tracking (Thorsten Leemhuis)"
<regressions@leemhuis.info> writes:

> On 30.08.24 11:35, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>>> Unconditionally honor guest PAT on CPUs that support self-snoop, as
>>> Intel has confirmed that CPUs that support self-snoop always snoop caches
>>> and store buffers.  I.e. CPUs with self-snoop maintain cache coherency
>>> even in the presence of aliased memtypes, thus there is no need to trust
>>> the guest behaves and only honor PAT as a last resort, as KVM does today.
>>>
>>> Honoring guest PAT is desirable for use cases where the guest has access
>>> to non-coherent DMA _without_ bouncing through VFIO, e.g. when a virtual
>>> (mediated, for all intents and purposes) GPU is exposed to the guest, along
>>> with buffers that are consumed directly by the physical GPU, i.e. which
>>> can't be proxied by the host to ensure writes from the guest are performed
>>> with the correct memory type for the GPU.
>> 
>> Necroposting!
>> 
>> Turns out that this change broke "bochs-display" driver in QEMU even
>> when the guest is modern (don't ask me 'who the hell uses bochs for
>> modern guests', it was basically a configuration error :-). E.g:
>> [...]
>
> This regression made it to the list of tracked regressions. It seems
> this thread stalled a while ago. Was this ever fixed? Does not look like
> it, but I might have missed something. Or is this a regression I should
> just ignore for one reason or another?
>

The regression was addressed in by reverting 377b2f359d1f in 6.11

commit 9d70f3fec14421e793ffbc0ec2f739b24e534900
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Sun Sep 15 02:49:33 2024 -0400

    Revert "KVM: VMX: Always honor guest PAT on CPUs that support self-snoop"

Also, there's a (pending) DRM patch fixing it from the guest's side:
https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9388ccf69925223223c87355a417ba39b13a5e8e

-- 
Vitaly

