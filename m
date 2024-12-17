Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F8A1D9A51
	for <rcu@vger.kernel.org>; Tue, 17 Dec 2024 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466252; cv=none; b=AHb39xsKKIejVgskwj5k8xrr59XZBGGb7grePP/5//DPFHPMcM+TypnfIIe9H0KmFGgj2QTCZPa9ILLshyOQI6YQE3XhpW4AQmi8WeBDDM7BHaW2HuJW3bkGXV4KYvUE/qUa43/8AndN+HZQC3l/dkKE8QhUS20QYzMFykKKODc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466252; c=relaxed/simple;
	bh=S9DoO5a3n3vU6X/je+MmroDxVIgCBKe2ddmDuJmV/mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoHYfAEXG86WNbB9kW7oPzIHQiyetfwcWB+Xi1cdqfmvPcIT/TxR5BY5mkRc0vSSifCDccjRjG8uZbiVVY1N0zM9kTJRyf+b8fb6pStMk9GDmZ8+Ay5vc9adupNMuATneLuEu0ADtvvbMwuC0mbULpBeQ8PPwxvUtXuTG6F9CwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SC9ukFpk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SC9ukFpk"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso409155e9.0
        for <rcu@vger.kernel.org>; Tue, 17 Dec 2024 12:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734466249; x=1735071049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ptCMEfalScg4HE+s2WF5iyeS7CJ5LoQymYStrG4iRVc=;
        b=SC9ukFpkLeX3Ab8vupeb/6U3Sa1A4Yipa5Mmdt8mtiVcxh+XXswWzrgJgXeHwePziS
         WkLJX04TvTtVL/MhOCQm6aoTqLiVxcYXjMl3k5LWGH6dA88qrBu9gUCGrNyfmKCUbfli
         vSzaWP202LoVtzqRWAu6fgcg+MirDJ3bzoZmcbVu9vMELpftpzrRI9r6OrjZQIDJwQVa
         ztTMtwqswcWWH6nQxzq+GpVSGFDsEGNNkTYYo5pBZPIdy6IdL5MpaRDcYuoRnJdthoPJ
         5yCFYmNgcvrebUTMuzfbL8FYmgiPT6br0zOM3IIXw5UklsLbIE25/qe5SK+otRuxwd2v
         okPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734466249; x=1735071049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptCMEfalScg4HE+s2WF5iyeS7CJ5LoQymYStrG4iRVc=;
        b=IXaULpiS/Wxnlexyv4fYnwCvpC1j7pFTboioVvJUM0Hexo5DhMd3hWhIWfK9QB9/LH
         Rog2vhfUBfd+bnlLv9z4AvzdKyZbbPnNuqxv46mTRYf3YmTxlQCEZRe6Ikpi3wLIVgqN
         53rQJ32zWyMd2pOMgJnJqS9SOM1gCEjtUOiEKI8UIK7BJ7gAdxiTwNl7PyT3urUV5M6Q
         DqSnexix8m05CHfT+buzk3umkV4oroxktJlPwMRcYjhUfa3hxHZNV8RyJOyb6X8b644w
         DId1XvuGtu0f0MphGhfv3hA3MwPLqXm2dW5TGQKS3ei2ldEeiNieLjyzP74P1x27Tis1
         cbMw==
X-Forwarded-Encrypted: i=1; AJvYcCUDHag8kP0EcOIQDJ9c3mIzwTA2ZDYmWan6rUgFDZIyTTvnL7UOIB5SqwVsBezyFGSQiu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo7UkxHlYJGlBpE5XJGkvzBRkBeBJTPyYu9grSMZJNQ7eLRkV+
	I393Puk/Y6k/JR8N2rbsWsNEDsWFk8Hj50Xm30BovvtlbhyRwU+Kn9DoxXEzPFOfcTFEZiF5NjZ
	8B2CHQgeXa44zHChsNVGIAWHwucu5S483SVVC/Q==
X-Gm-Gg: ASbGnctXbfTLSGdVw0cMQem0B265choO8yu2DfB/1s/kRvJwH00DdTiHk/iKZFIwe0Q
	X61wacxLz0Zr4j1ryw1OjF5q9588CrlI/8rk0LUkvhbmJbMra2vDjLYDwiyeh/xG091Qf4A==
X-Google-Smtp-Source: AGHT+IGKGM3GSJM51xtpyhc2/6RhhD/S1kZ/YygELvpxDkqeIEk+YG5SrrmAjsx+Q88wsvntYUv7XsFnXak8mvmHL9g=
X-Received: by 2002:a5d:584f:0:b0:386:3958:2ec5 with SMTP id
 ffacd0b85a97d-388db294b60mr4487740f8f.28.1734466249108; Tue, 17 Dec 2024
 12:10:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212163357.35934-1-dakr@kernel.org> <20241212163357.35934-8-dakr@kernel.org>
In-Reply-To: <20241212163357.35934-8-dakr@kernel.org>
From: Fabien Parent <fabien.parent@linaro.org>
Date: Tue, 17 Dec 2024 12:10:38 -0800
Message-ID: <CAPFo5V+WOWzzXxN=-n+ADrFdkSV7C66Lq-+gitx+TnrsAzYJnw@mail.gmail.com>
Subject: Re: [PATCH v6 07/16] rust: add `io::{Io, IoRaw}` base types
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, chrisi.schrefl@gmail.com, paulmck@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Danilo,

> +/// ```no_run
> +/// # use kernel::{bindings, io::{Io, IoRaw}};
> +/// # use core::ops::Deref;
> +///
> +/// // See also [`pci::Bar`] for a real example.
> +/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
> +///
> +/// impl<const SIZE: usize> IoMem<SIZE> {
> +///     /// # Safety
> +///     ///
> +///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region that is mappable into the CPUs
> +///     /// virtual address space.
> +///     unsafe fn new(paddr: usize) -> Result<Self>{
> +///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
> +///         // valid for `ioremap`.
> +///         let addr = unsafe { bindings::ioremap(paddr as _, SIZE.try_into().unwrap()) };

This line generates a warning when building the doctests on arm64:

warning: useless conversion to the same type: usize
    --> rust/doctests_kernel_generated.rs:3601:59
     |
3601 |         let addr = unsafe { bindings::ioremap(paddr as _,
SIZE.try_into().unwrap()) };
     |                                                           ^^^^^^^^^^^^^^^
     |
     = help: consider removing .try_into()
     = help: for further information visit
https://rust-lang.github.io/rust-clippy/master/index.html#useless_conversion

Same things happens as well in devres.rs

> +///         if addr.is_null() {
> +///             return Err(ENOMEM);
> +///         }
> +///
> +///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
> +///     }
> +/// }
> +///
> +/// impl<const SIZE: usize> Drop for IoMem<SIZE> {
> +///     fn drop(&mut self) {
> +///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
> +///         unsafe { bindings::iounmap(self.0.addr() as _); };
> +///     }
> +/// }
> +///
> +/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> +///    type Target = Io<SIZE>;
> +///
> +///    fn deref(&self) -> &Self::Target {
> +///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
> +///         unsafe { Io::from_raw(&self.0) }
> +///    }
> +/// }
> +///
> +///# fn no_run() -> Result<(), Error> {
> +/// // SAFETY: Invalid usage for example purposes.
> +/// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
> +/// iomem.writel(0x42, 0x0);
> +/// assert!(iomem.try_writel(0x42, 0x0).is_ok());
> +/// assert!(iomem.try_writel(0x42, 0x4).is_err());
> +/// # Ok(())
> +/// # }
> +/// ```
