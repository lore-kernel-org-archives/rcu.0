Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6015530B;
	Wed, 18 Dec 2024 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734550405; cv=none; b=SPFjiuFpZNoWYaRp/CxCGBw5/yP9QTMvkm1QPWHSR9LEsV9co/eVwokdb4MthVlN0LakgYNddCPuXGGPwEdWN8Mk7Yio+BpCftirG1orAUH3PRP9uq7lyHNE+KYk0sjEggjqmUfzSXG+ROG8L2/NlTxpFh3Z0i4Xrg5uaqfEAAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734550405; c=relaxed/simple;
	bh=+ZAP7+0oy3nKZio2i6ug1WK09BMQLlLYlaeIKRXupWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grp6bB9bcmwrWlUkJXKBCYeCru3WaLm3rN4yrShVLMQUVthJHkz2xmtQEUlZ132Mc5vqq/YUkOymtggBckFboZp/xsqZC69hQMirTPBPvdflvhLg7qbvwPLB7bHgfohG3soOtcSdLYhWxqcGjjC/Vr13bZyRnT5hlB9Ney9WUL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6e07Imc; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6e07Imc"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so2058571a12.1;
        Wed, 18 Dec 2024 11:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734550402; x=1735155202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hWtbSFsMz/oC2jOH0aIgScA+tGd7yJMd0DBJ4xjasjI=;
        b=M6e07ImcgV9x9I9Iku2hSpnD8aA//vlqtshQRK4n7IWT/pepNSsGshSXfnCSFj4FWm
         xEE1p+2FmESj6qScSAbjmt6gfV+j4HtwWfV1HbF67ZedmgdJUd9GhyqvIJtYFu+QUE+Q
         GohfSu0eoca10lY4E3muhTKC7K4d1Hgv03aQEG230wF+vQZM2RtBV//+hNoRQjEapD6Z
         58qM2+vD5YwAX+YhLH2JJuAMK5Qr+dh7A6hs1MijRqooQk1LDnIQd2LbBWE5YLtvxz8Z
         tnqLB5jMlLJ81bhKuiWd1zKi/hTy3J0SOMzeSRB+7I4IZTos9T05Xu4xHP4UoEMyh85P
         OVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734550402; x=1735155202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWtbSFsMz/oC2jOH0aIgScA+tGd7yJMd0DBJ4xjasjI=;
        b=Md8V47BXc2C1oTrGK46WB4m2GnsaOlR398pVDXDKAZBG+Cr6d3IVufMjw6cfaSj04R
         YmikGcg9f425vh0JnLtblNMxCPK4p2ct/Q0LnFhuemj/hV8B505JXDF+qojQo0bpxhDU
         LSumvPSD2DxpQOsC5HALMM0Ni6mUITfr77q/vv3rYBKxA3rhinx3iFFH396ocCgPHVO5
         66OHkeGfoH6GpWZ4XI+VzQdMvydDkyIYPQzmRtJE1WXIaWXITQuuOrdxv4EyrBxAoB9x
         b++NZWXnhy2FQtAohS7eNOQ8ZAImug2PWqRnM4S2Q3+NoX//sukUbNw9nWP3n1nhyVKs
         z8VA==
X-Forwarded-Encrypted: i=1; AJvYcCUZbPZH/zn1vm4CxlUZkTqZrfVPQPXU9tjetprHzgWw4AgcVCQMk/4qm9jYM2X86yzkJwi0HSfc/CkyJw==@vger.kernel.org, AJvYcCVMFn78bHI75bcNRprS4pDce8X2af0fMuvBv1MAmbfhF4SE57L0/Mmg8C7iCbTqSf6Hkunz@vger.kernel.org
X-Gm-Message-State: AOJu0YxESIuzRRP6cu77vXdZs0lFQQ1Mt12AGOB+BlTMlkF9j637Dfpl
	EtfkP1Cbcv2o7s/Clr8EGzxuIodCdP3tUZ9Xnxp2kCU3d4aomGCE5m7Kagx4zdaQCjHEVS3fOox
	ttn9wexWs2umUhkUJNVSbo2paaX3kx6QM
X-Gm-Gg: ASbGncts+hju8vU0EusfMn5XNpgL8NUirp4Nikqcx/I4qeYDx/ZtrszW6zZkm9NjvcO
	WtdQ/a/uwK75SceWJ3Kkq0TjEKywCUIqdl3wsNps=
X-Google-Smtp-Source: AGHT+IG4QvqgLNADjWMXuG9FuJApOyyQbltuSf/xlK1NiiagTINcsY9FTyVPMn3ZfjRiCMX5GuTptbBWJyDdquFkEj4=
X-Received: by 2002:a05:6402:390b:b0:5d0:e461:68e6 with SMTP id
 4fb4d7f45d1cf-5d8024822a5mr457904a12.17.1734550401381; Wed, 18 Dec 2024
 11:33:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+=Fv5QH1nUO1D1=Osqic6mNN6vLxiLqvNA4D9uAUgZA_w+7Tw@mail.gmail.com>
 <0b338882a82c3f505407cb313b89a2c7f891d982.camel@physik.fu-berlin.de>
 <CA+=Fv5RDcgm4YSX1AcpOgLvL=XXKyA=71ZasbJSc7+79Kh_Xpg@mail.gmail.com>
 <d9330edfca0fb34c69a68c56924fa0b074b26d29.camel@physik.fu-berlin.de>
 <CA+=Fv5T9nrQjGHOR+42tfgT723TJGgyVqBY7CwY4L-gYSoWTag@mail.gmail.com>
 <c661a771a86267c158d7f2eba1494fe94350fb06.camel@physik.fu-berlin.de>
 <CA+=Fv5Rxrwn0SEMgjufJcxSaB0_gOiKBjXuZnSKzgKakDHeCOw@mail.gmail.com>
 <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com>
 <Z1YpKFQGtMWF3yy3@creeky> <CA+=Fv5Q=f-6y=EhZhG2XfZB0O=m+yOiv+gmtmMABVQZieKdwbQ@mail.gmail.com>
 <Z2ClSlwznfuk8Uwr@creeky> <CA+=Fv5RaqHL6MJjvhF-mn3CVY10e=2QqFBSVO6YXLUJ7WV9zGQ@mail.gmail.com>
In-Reply-To: <CA+=Fv5RaqHL6MJjvhF-mn3CVY10e=2QqFBSVO6YXLUJ7WV9zGQ@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 18 Dec 2024 20:33:09 +0100
Message-ID: <CA+=Fv5RP=NoWo4VeTX7hx103=jP2d-NC-jFo+ePXLBRubCxc_w@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: Michael Cree <mcree@orcon.net.nz>, Magnus Lindholm <linmag7@gmail.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, paulmck@kernel.org, rcu@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"

Hi again,

So, various versions of GCC can trigger/untrigger the RCU bugs that
I've been hitting. This may of course still be due to GCC miscompiling
some code on alpha but that said I've taken another look at the code
involved when this is triggered. From what I've seen so far, this
happens when kernel threads are used in the code to access structured
data stored on the stack (structs). The quote below is from a comment
in the kernel code (include/linux/percpu-defs.h)

"s390 and alpha modules require percpu variables to be defined as weak
to force the compiler to generate GOT based external references for
them. This is necessary because percpu sections will be located
outside of the usually addressable area. This definition puts the
following two extra restrictions when defining percpu variables.

1. The symbol must be globally unique, even the static ones.

2. Static percpu variables cannot be defined inside a function."


Taking these notes into account I've made some minor modifications to
the code (briefly described below). The modifications involve
declaring some structs previously placed on stack as
DEFINE_PER_CPU_SHARED_ALIGNED. This is already done for some strucs in
rcu/smp code. Making these modifications fixes the problem and I can
build the kernel with GCC versions that previously triggered the bug.
The same approach fixed both the network interface-rename bug as well
as the scsi module unload bug.

in kernel/smp/smp.c
-------------------
#if  defined(ARCH_NEEDS_WEAK_PER_CPU)
smp_call_function_single(...) use csd = this_cpu_ptr(&csd_data)
regardless if its called with wait = 0 or 1. Make sure to declare
csd_data as "DEFINE_PER_CPU_SHARED_ALIGNED"
#endif


in kernel/rcu/tree.c
--------------------
#use rew_data instead of stack allocated struct
static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_exp_work, rew_data);


in kernel/rcu/tree_exp.h
------------------------
#if  defined(ARCH_NEEDS_WEAK_PER_CPU)
void synchronize_rcu_expedited(void)

in stead of:
struct rcu_exp_work rew;

do:
#if  defined(ARCH_NEEDS_WEAK_PER_CPU)
struct rcu_exp_work *rewp;
rewp=this_cpu_ptr(&rew_data);

rew_data is declared "DEFINE_PER_CPU_SHARED_ALIGNED"

#endif

/Magnus
