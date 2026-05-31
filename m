Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF62C11E4
	for <rcu@vger.kernel.org>; Sun, 31 May 2026 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780253603; cv=pass; b=B46wBc0LAnqD7jrs7fIM6CLf8N5ia62v1XeqrHNzuPY7ssrX3yGY+Ijk8KOxlPbL9xwhYCHe9AuHoCc8zF6RJGsCqpwlzK+Wn22gyD25SyRRmBXfB5hdkRuKYvepgWse18ht76hoHHH3xugFTj4/NFyv2T6iCXxPJVrhB9vwUOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780253603; c=relaxed/simple;
	bh=jgPxYYhrUPADA2UCr3MF6jfqPwTFJ6/F2LjSfEUcPio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqeCc71CKWDX9fJy3dYGZUWVw8icJq0t/BIuW0yAEpco7bFyfn4+LxdAaHkvr6y0UwHAbNg+qxz9Ja57Akj/qi3eqw4ZORkZcUq/LYXgiHTSG2LQLEL4KSfXtruEC+QvVtZAXmrtUX1nFgcdS17hFlurh7Tw8Ixf+VvPBAlosSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg/9W1O3; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg/9W1O3"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-304cf9a02f9so373377eec.1
        for <rcu@vger.kernel.org>; Sun, 31 May 2026 11:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780253601; cv=none;
        d=google.com; s=arc-20240605;
        b=MXM9DjCF5jrqF/8PlewdOIKL38XcGEABQp9dlUThNbjd2tjaCM8PM8zWSRmwhG3dw9
         vTrsttNC0+p4cOQZ5yHORE84tmOYeIkL03oICUGinAOKsqrcPFI3mebmXewAMHTXmHbS
         iDiSB9SClCg0qrLN0IX/s+t9OyLr8Hblse7cPNsdOltyYKUV3UqCbl67enXFrWYwfPle
         m0cvH9AX+yTvQnM0h4jt+S+QqjQl/DHvKQEfikYpgYu9+Ph6OuxJIW23STO3dk5oraaV
         OQLotW1nzlH+SPwTR/UKbwhzAedrSBhpYEm3YLkdpKw+cqkNhO1BaHc0gUOkXGVs5eYN
         sjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jgPxYYhrUPADA2UCr3MF6jfqPwTFJ6/F2LjSfEUcPio=;
        fh=FFMFLnnXIPpQp/aCe1o0jdwUIjJXiOEm3srpQM/BkdI=;
        b=R9/pwgdGwtIwQdlOBPZQVTvQ3UVI9hu4QRgLo15DztYoMGktID5LuA0D85RA9EVpjo
         iKnM1qkQeNLNYR9bGs7Kamz8u5coy7cFljT1vQZN9x3kIJbIUYipONEgsNf7VTPHvNjj
         5HWOeYXYVrl3a4+4P1KJti771ai3TWjhanQIlZ2Zps1H8ro627W7dXGNKerZ5LzVzodE
         DRV0gYpOX8vsgyDYBu1IgHVFzzS044VE9UbpiURtYF+e2bhqMmQSD2U3rEAGhg3I83Sh
         K53vJ/6A8HruRWxr42C4ALEhcKhVEObifpkHvPdy/oaRzHsnS8Rz/mN2iUAR/1/9M302
         xEcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780253601; x=1780858401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgPxYYhrUPADA2UCr3MF6jfqPwTFJ6/F2LjSfEUcPio=;
        b=Sg/9W1O3KOSLGeG7x8n3RDQYPVJowCksJgEqkGI/D8ZXVT4XWXvQ/4PbAawaeiRlEm
         xjF/GE0GS9xEIcpKbWQ/B3wEViI+Vo1LYH6ysC8VK2j4RlvAvoBLJ4gRy//77JdlBP0E
         lLsw0F8U/mNoyIM0KoBV5ZPGmao6/tykgcU0brkk1izb5ZRsOKniMe4xcJ42I715rNEh
         3iLWeLAhT9oVYOXI0jeT/7OUPgOpsXzulRe2qtubFgEqZgYt3/R0Fj82v+fISefobcth
         HBjIG7AImD0onK2zpJ4dILRK9kWGngcgaEHv8Pm+hMC6PvD+JylAU6FaP/WCJLDFy1I/
         QjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780253601; x=1780858401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgPxYYhrUPADA2UCr3MF6jfqPwTFJ6/F2LjSfEUcPio=;
        b=nF0AQZjhDyYQvKI+LEMIceaGJxoVBP92+Jg9Lfz9/v0Qt8S2TCfpGOTiCPhteBhhZ6
         jZpMNuakya6nVZjHU6gaqC5AUSGrfKeromj1cv/ESbK078CHoOsHqmeAGu9XNjTr6jNW
         zI9BaTQq1CURCi+XZ+XcBoFsGuR4/60qKvLAdz6PMsPVC3HGoUUdA0EfryLOBe8rQWSe
         ZmWQ41Lm0dLlqb/S9Syiz/kTbIUk3EML1tD0q3BDJiqmsIGxl+FLf+5qcD1+oRaXQ66u
         3Kv4bOEreNFVlg1cfhpm+8o+HbLg8bvY3vvKX7kw6ZHoM7mrcbY9/uyspZtQlJklJD1X
         +I6g==
X-Forwarded-Encrypted: i=1; AFNElJ+2I+PvpcGbsMMb4mTda3Hi0urtD0syMxm+wrOOUGVGgw7/yMtp/Dxfpr/qMHQzITBjisY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyusI+NbcFgUblNysbgiyz5Ziilz5DquiA4fqes+v62of7yrjZt
	rwsZ+f3URv7PmjYUDYA9WGvOASGE/xRqPwk7b60igGCXu6JiKzbBZ3pc3sRSwrZCWydJkXcqf9q
	k2deECIm7flmLEFG4G5IndM8SyrCjZZ0=
X-Gm-Gg: Acq92OGr3eLoRNoW3/79fQM0TLqriqUHvBgrQz+T8tDlQ7JuPj4jEzYHGto5O66ZF0N
	lE8SPQQGrvoQeFBWLbYditDYTQPmu3ePv5PKsPZWYU/cJaWrrWAidbe+V5BcZf/d/JQ/OgINK/j
	gb6tBUrkZEgeAwfMI2IGZ/G38RFzXZYNGo1Nxni4Q1b/nJ87juENRQK4v2y5DRhetljt64vUM3U
	7xgkzwopv796nQUVtCwnkHNgGEO8n+2IgQ82xrxcad0fZ0LaTtfK9Jau4H0W1pOmirOP8LdbLrL
	vbdaCe5C01J27cWRXMreAJ4ruON3ZdPaxOW4ypYyzyHz/uwMnb8OYKdDL6UOffWB5vK8Y/SiXos
	e9ZwaK8mjr4PzQjPwV5h0SONLZKYwaGwoOw==
X-Received: by 2002:a05:693c:2c86:b0:304:f860:3ae3 with SMTP id
 5a478bee46e88-304fa49e500mr1849902eec.1.1780253601227; Sun, 31 May 2026
 11:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528062810.256212-1-work@onurozkan.dev> <20260528062810.256212-4-work@onurozkan.dev>
 <20260528082025.44414-1-work@onurozkan.dev> <20260528083518.66203-1-work@onurozkan.dev>
 <DIUB2DNTF6W9.2BT1NF6UXUOFI@garyguo.net> <b4f6d3e8-3a08-409e-89ae-ba5d612bae30@paulmck-laptop>
 <20260530062730.38077-1-work@onurozkan.dev> <3ef86db1-edc4-4e50-8614-2dd7270540b4@paulmck-laptop>
In-Reply-To: <3ef86db1-edc4-4e50-8614-2dd7270540b4@paulmck-laptop>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 31 May 2026 20:53:07 +0200
X-Gm-Features: AVHnY4LjPr_-R-w9GEV0I1IedUBZ4-Zsh5wDmqL_ofn06vbOsdcxe1NMN3VRKCA
Message-ID: <CANiq72=jVHEu5veW_k9B66avYgVR2aHDN2QmDny=j4EK2uRXbw@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] rust: sync: add SRCU abstraction
To: paulmck@kernel.org
Cc: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Gary Guo <gary@garyguo.net>, rcu@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ojeda@kernel.org, boqun@kernel.org, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	peterz@infradead.org, fujita.tomonori@gmail.com, tamird@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 8:06=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> Is there a Rust-language counterpart to checkpatch.pl that could warn
> when it sees patches adding calls to this function?

We had some patches for proposed Rust checks for `checkpatch.pl`, so
it could be there (there was also a proposed `rust_checkpatch.pl`).

Having said that, Clippy's `disallowed_methods` is likely better
(modulo bugs), and we already have a couple entries on it (please see
`.clippy.toml` in the root). So I would suggest that first.

There is also Klint if something more custom/complex is needed.

Cheers,
Miguel
