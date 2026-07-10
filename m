Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA541168F
	for <rcu@vger.kernel.org>; Fri, 10 Jul 2026 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687136; cv=none; b=lX1d8jV7DYYRlXDoPFsI9C3deFeGlJFwHO/7Pklg8TBFk2x+8o/mSdNy1gSUUyWacE1H4Z20VBYe+VfS0N/tcoJL8s4f6prNasPbEdrrrKyfa7rbE6tjrJMfEy9Qe3i9y2PNhUw3xBSgEc2WajI0gN/66psDOONDGc5ZtKOIxl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687136; c=relaxed/simple;
	bh=U0pCIOkkBwcHPALV8ZW+SpRSj0YYtvouOLJIjpCNEnM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M1j1m0p2VnOSVhx0vrNJiio3uVvuGZs5BjeEI2MNaj3qewb6JtkS3BDWbhCGBwomoU9HgeEcwU4XhVS/V3IAZQAkEfZd3guuKssM9aBfV3Q/0u+MN5r69ZCX4P65mH3E0TH/wYgRCYVXctf3xIySeUl8EFpNxPkYbJjzl414Za8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W9JmDYRZ; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9JmDYRZ"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-c15deb3377eso76280666b.3
        for <rcu@vger.kernel.org>; Fri, 10 Jul 2026 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783687134; x=1784291934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U0pCIOkkBwcHPALV8ZW+SpRSj0YYtvouOLJIjpCNEnM=;
        b=W9JmDYRZuoG0G7ZCpp7CpuuqFCU8D0DcOMAExhjZNhzwAKu5X1ok9qNc0eLwsEHGT+
         FAbe5KyQCY2qDpmVvldkRP8P7a2ertcBkCM8teFSfNaaVZEszzx2cSKdFXeXpxuq3DJk
         6Tgykc9G5otieqk/m6Z+/dgUIZBgBMu85FlIiMOjkw3vpJxzaTg2zYk7Tgjjt+lI935l
         s8ek05vKiO/K/U5yD7ChZ62m2DzmcUidEpqe3hWgTLP8ZO+JXXxH3ERwVCnZopM8m2W0
         Vgkr1D4Yts0ven+VoWozE+Yxow2JJF4JH/5YO4G73LDUOmii7NSj1jA4+AY7DczwdaRi
         8HbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783687134; x=1784291934;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U0pCIOkkBwcHPALV8ZW+SpRSj0YYtvouOLJIjpCNEnM=;
        b=nMEM1dZKgNd7qQIFWY6eyouCRrRZ7MCqksyYA4wfejZdKub3vZCyU581tppOFVg9/1
         +7ejjyyTBVQudBmxrS02jvNqnXiGKGBOo6YaXKKG2V7vErGC/V5uvXX8JOWE+TBQflh1
         u2KoYnEpPdGn7yK4STFu+U1L5PFDf7JI86OK12S+abEHkh+tJ30YZR3+6c9Yev5w9jR2
         f9xRZFt4X1n4pniHzaEaPYEHxQ7RyeN61h2lpd2Ix5UiUrUGcrkYDUE9cJWnwnjXtc0A
         YjKBeRV4Wam2ale0mO0Ac2Vz+GZK9aZ01HY4hqcyKe03TRcbQk4pfxYlnlxs8Bfeg+ON
         AR+Q==
X-Gm-Message-State: AOJu0Yw+zgyAlGfQBLWMACsAxCwnYoSNly+3BcABLAF6Krrk2io3zQQB
	FKccdI5IpAM34/KhBXGuQCmQVufuJsaFaG5pCSSiSmd3JU57qdSmop/DExlEwcUdLUM0i3pVYNF
	oq5SzdW5ei+iRvztq3w==
X-Received: from edt16.prod.google.com ([2002:a05:6402:4550:b0:69a:bfa3:e91d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:380c:b0:69a:44e0:7455 with SMTP id 4fb4d7f45d1cf-69ab449f3b2mr3957223a12.30.1783687133242;
 Fri, 10 Jul 2026 05:38:53 -0700 (PDT)
Date: Fri, 10 Jul 2026 12:38:52 +0000
In-Reply-To: <20260613065348.96750-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613065348.96750-1-work@onurozkan.dev>
Message-ID: <alDn3IIAVWK87YZy@google.com>
Subject: Re: [PATCH v10 0/5] rust: add SRCU abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>
Cc: rcu@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ojeda@kernel.org, boqun@kernel.org, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	peterz@infradead.org, fujita.tomonori@gmail.com, tamird@kernel.org, 
	jiangshanlai@gmail.com, paulmck@kernel.org, josh@joshtriplett.org, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 09:40:06AM +0300, Onur =C3=96zkan wrote:
> The immediate motivation is the Tyr reset infrastructure [1] which needs
> to serialize reset sensitive hardware access against reset and teardown
> paths. That reset series started to require many independent dependencies
> so this SRCU support is split out as a standalone Rust API to keep the
> reset series focused on the reset logic and easier to review, rebase and
> land.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
