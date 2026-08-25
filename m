Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7D233926
	for <rcu@vger.kernel.org>; Tue, 25 Aug 2026 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787692520; cv=none; b=HMrbQqy8E2SXjK+G7r2r7tjhy6/G9ha3iEs6YuFNXT2LqZRR71yE4ItKnM26+XaGJ2FDEkHBMJDr3VJaOvUVat/4VhHrfN9F1hez+MAbpggbxngQRu0dpSWe/c4wd2i8beiZ8O6+c7gc9sdB7aPRdCKS3y6oKfH/gbwEPOwjbdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787692520; c=relaxed/simple;
	bh=YURfK5Uyl/UslKrtEwDDwLX0hh92nBTmSmCT1nZ/Jy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZS38i5U6FE3aLlhRJI/bamy8arJmB5QtV6DyvPBlsnobfPUPxZtzudxPdssmLsAlN89mw/HTdqQrQCH2xSkELgUMHLpNIih9bttgDx2+DCHW1eZFZmdRkAvpeMlBggZkMV9sAxU9egJonIylOAds3EHdaWCACotqgo8GMnbVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nOj1365+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nOj1365+"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caced6038eso3587595ad.0
        for <rcu@vger.kernel.org>; Tue, 25 Aug 2026 14:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787692518; x=1788297318; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tnEjGuRBMrF8OQ4yR+cApWv+K6yNEUZHSJjav2O2NEo=;
        b=nOj1365+XuUjcXy4+etUBXOBEeyuPVH0Fs1kfNB+vxfvjphZYlkqbeUqYtuGkQBn2X
         ruIJLwFxiYgDEe7YClFEBG6FobZBYCBtRMFenhtrRKgd1LPSl/+e1K7C8KKL3lw+J3EX
         y5kVd2/yDaymXiNqCGBSf1A31nV90mtrkNzrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787692518; x=1788297318;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tnEjGuRBMrF8OQ4yR+cApWv+K6yNEUZHSJjav2O2NEo=;
        b=I6Y+MhfBhRRQl/k6YMKrv9zxsPuvlcZXSngfj9m+n7QAdjtIEWUnsaCDZeNb6DKG8M
         EULlF5dAzGfPKrQMeSoQJg1pKHOjOIisiIPE+THuWjrc82qKEZ1UXwYYnkxWwwMEk13d
         GNhUT8ZrwaWDlTTNH2apAtByFuZKGXwrmVmvlGfVp1gM+1/54JWAEy20H/UY8lsUKR/W
         nK+h+tK7ovQIrCTkthicwK1b/sJkgHfXiktV8aa2TU+ekvbkXmPibrNZpgep4Poid5t5
         PCBK9PAj+nbKXvigKorlUZmP48b91xo9uY3ZrjkYYzLw1lNRghRnHfVxYVmrh3Q7ek61
         sNew==
X-Forwarded-Encrypted: i=1; AHgh+Rpu8EoqFv0UTflX3Kg7VrJzIR/XRpqgmDngnfM1NQ8b7jHGnCtPFrYCHF1UnxQAxqtzsWw=@vger.kernel.org
X-Gm-Message-State: AFuF++niLgz8Efy1p/tYrIfKnClVSldzpHIjwFFH5VYNvLl8mUKyUek/
	ncEJzbrQb7dISQANDs6h530seHtbhnBbQlLtMuNE1iWpMmsLpa81d7skHCCALiIs1wAowRxeepp
	8dRZp+BqV
X-Gm-Gg: AR+sD10cwb4EoFkR7znXpKLDF27UpDgTVfIVPVdGPV5ZGfDhBbFUrQ2ZH4SN5PNa09Y
	kO0pYeTVCq6ekpAMKf814xiiPWQ7E9EVKEgBE2GfuOyoRfSDcf6kfyRxnYx+PhbP63oyZcQRBnU
	2FDZc1xd8rhRn1XDeezo4P7NjgpG2Ym4kD1kt0AayqErXU9ive/iJzsqNmZCpp7hXmKTxnLjqrY
	PCMfGom4YgfREmHdPmGz4GHt3mGvDGfq/EWXBD9zyOUPjdIgr6RswRpzzkaKtg66A9exGAPZJnB
	FQrwX4fPs+QWauuJZ7E57vyTu2P8WMOs5VPPm873Dhfg7k6NH1jTVOrNUhqhHA+HlvnpzTwTcwC
	uIUs3FILRjbNh8YyfhIL/lPTTgJnIehUjVSgD3kNLgB7AYzrMlin/gnRkVUshClWc5AIe/v9xyf
	N+2q3q/mt/l/4K5ti5fdRieN9XfDhKuXhKscyj9mSotHeHLnALVhKFOC5mw/vcz0MgL+tecaoxY
	X844rLPAwH+YD+oF5bRe2wKnw==
X-Received: by 2002:a17:903:32c6:b0:2cf:6e5d:23e9 with SMTP id d9443c01a7336-2d6dcafd0b1mr103511725ad.14.1787692518264;
        Tue, 25 Aug 2026 14:15:18 -0700 (PDT)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com. [209.85.216.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704ba5ca3sm1873225ad.41.2026.08.25.14.15.18
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 14:15:18 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39647184c73so1302170a91.1
        for <rcu@vger.kernel.org>; Tue, 25 Aug 2026 14:15:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpZThsUyV0F5CTPmF2LJ9u2jzQ5F0J9BJvzag4fFBOSrx8xLmD0dP/22XTEc4RX25XdEgw=@vger.kernel.org
X-Received: by 2002:a17:90a:da84:b0:395:c3f7:2895 with SMTP id
 98e67ed59e1d1-3964595f81bmr13838317a91.7.1787692515109; Tue, 25 Aug 2026
 14:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-unqual-v1-0-7024fb81b4f9@chromium.org>
 <20260825-unqual-v1-2-7024fb81b4f9@chromium.org> <2a772433-b0b7-44ff-a655-f8c26ee54d0e@intel.com>
In-Reply-To: <2a772433-b0b7-44ff-a655-f8c26ee54d0e@intel.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 25 Aug 2026 23:15:02 +0200
X-Gmail-Original-Message-ID: <CANiDSCtP3krujoBo0Ai2xSrA5gkgmG5vNQuNXBDX5kK-kbRA7w@mail.gmail.com>
X-Gm-Features: AcwNN1XprkieNuPWISz1-fUJmPSBmHlJpGPLYqSNhbYOg-RTqcJ_oTdY8LAhSmI
Message-ID: <CANiDSCtP3krujoBo0Ai2xSrA5gkgmG5vNQuNXBDX5kK-kbRA7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/uaccess: Fix casting in put_user
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Dan Carpenter <error27@gmail.com>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dave

On Tue, 25 Aug 2026 at 23:06, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 8/25/26 13:02, Ricardo Ribalda wrote:
> > Recent versions of smatch preserved the address space qualifiers with
> > typeof()[1].
> >
> > This fix has discovered an invalid casting in put_user.
> >
> > This patch fixes tens of smatch errors like the following:
> > drivers/media/usb/uvc/uvc_v4l2.c:1112:13: warning: incorrect type in argument 2 (different address spaces)
> > drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    expected void const *from
> > drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    got unsigned int __user *
>
> Could we beef up the changelog here a bit, please?
>
> What _is_ the invalid casting?
>
> What is the fix?
>
> Why does it work?

Something like this would be better? I will send a v2 if there are no
more comments.


Recent versions of smatch preserved the address space qualifiers with
typeof()[1].

This fix has discovered an invalid casting in put_user.

put_user is using a casting with __typeof__(*(ptr)), which keeps the
qualifiers (__user), instead it should use the macro TYPEOF_UNQUAL()
that will use __typeof_unqual__ where the compiler supports it.
__typeof_unqual__ copies the type but not the qualifiers.


This patch fixes tens of smatch errors like the following:
drivers/media/usb/uvc/uvc_v4l2.c:1112:13: warning: incorrect type in
argument 2 (different address spaces)
drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    expected void const *from
drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    got unsigned int __user *

[1] https://github.com/error27/smatch/commit/e53027a4e816a772403baafa83c09e4a94c1cb8f


-- 
Ricardo Ribalda
