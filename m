Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D62235C180
	for <rcu@vger.kernel.org>; Mon, 10 Aug 2026 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786341648; cv=pass; b=gF3jcguJKIvxkJdoh6GgssZHjxZWCq6e0CzWAL/CNGrjFvsR7sa51K1PbwVhXw2vMXf1LPUgA/NrHLJraqJ+0dIlhq/59Z0oydtOpJ5rJhWyBc3WiVElAeURHYg1tftYHbx6Mw/08GdmhHXkK3XywjymKTdzj9C/WplRIAgV/F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786341648; c=relaxed/simple;
	bh=A6k/r7nYTVXUKSwr3yMiCfaokYfSJx1y4Hc9qQ/TqEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCBuwO1erqUVpaMtdJK5Ybjo9oZNV9oavP6E6BduVKJQ7IiCktywMmTiKEBn7qpVFPt9KCIroHtEliaNKnm0YiRZrHVYKKmGP0GZQrJHmGsjiNgdB4EbW72Hmx2ucvHx5i9qbyGUf1DUD0EjNvMTk5K2Y+wPJF8XkYndwqA0TXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYpHZf9Q; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYpHZf9Q"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d027b7c8easo4494155ad.3
        for <rcu@vger.kernel.org>; Sun, 09 Aug 2026 23:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786341647; cv=none;
        d=google.com; s=arc-20260327;
        b=R08maRcyhsv50PwP6KE7UkMscziteoYokqvTGR7gVCQrn5nZpC0g1wc9pw2A7TkQlY
         RK63f8VO4OKqYFbo+tqIVfOmnpHOsGipSMy2egPqi+jNQMf+f9S8C+9637ZvwkPWiZnN
         kDA4vUoe42anbB37E1CoNhMrkh4a5FORMSQ6CyLytUPKIaIgUolSpUceuLwSKbp1pwpy
         mwJnq26lTnSVkXhwz/5idsIVMGICROEKIHw7DVqn5F/GICotJKnHfgEk2K01smvvtnsN
         0gbo4QXUBFYwvApbz5eSF1eXcdTKk77EoxkbYLauK7fpq0XgxUWzpdmTRec1RDdUANaO
         tpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/zktKh644DXHbJuaAdqY5YkWn6ygQvUdVRJDbRh3y/s=;
        fh=h37tOHOSCPnXdJy0axjEiCc+u+XdZp5oTOiYcORUUJM=;
        b=Uu94ApJrjA2FSl+/bo4V2EXdniBCPshzSV8jC0BhcO3d4NGWKSxEoWviDvx/qcwHjt
         5qvFpFAQWwZkUO9AGTxeRmLo1E/UcxRFScrNI8mAn0sPQMyp9M1kQtA3gN3R12g+f8kv
         dt3fseFPZ26O/FrPPpCuBgfhipQhqBMLb9cv/03L5f/J40Atjw4dJFBLW3mJyhUyZwqJ
         oRz00328BeuW9EijybB6Wm420WumFpVROuQaKcGzgLWEkP2fHLutEVulPOgb6MTwWbST
         zGXFhpmmWECqBUJvbtY2YBnjY/IOnFuNBIleBI+70l9kxGwIvAe2YMNNM1VfCIlc4ntC
         cmhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786341647; x=1786946447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/zktKh644DXHbJuaAdqY5YkWn6ygQvUdVRJDbRh3y/s=;
        b=ZYpHZf9QY115h3MwDnkKbxBMMr+Iv89MgVxNkNhNlAHajVU73DOCfjGiYw/+ABvaLi
         g9zn6NoFBesZY1OTwDGdtNRnl1c4wbL3PjrXsCFvu3pO49D5tHNsaQIjfZ3C9AW21Ecz
         v9Wfc3cCw1kTurNn2r8Joox88FpHcmDTl59gVHBwvwM+EDv23zsKOvaDAVp27Q4DlpLI
         Uy2vOjnXKqvGQ5IjxxThXI8N7r+fLe+MOiCjeS2VA2uycwfxUC1gLo1XOZilEEsealhn
         XmSEE/yNfxHvxgIUk4i3bYCD19TwNYiVncwRokpwTZFRxQRep3mBkDWxb+Ar+fw7vY1I
         iMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786341647; x=1786946447;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/zktKh644DXHbJuaAdqY5YkWn6ygQvUdVRJDbRh3y/s=;
        b=EFMGRzUroAZDUdxRGGby6CQaYvl5KRzhHlKKDu7j/zhRni/y2YwN8GBgLZ6X9w29vE
         idJ0mSahuynnFsA9ZlLEp+V0X0Vk1yh+NMeKAqyWklLaPRTFqbUH9cXHBC+ZQ+LGqcwd
         B624DyDy2eCNkQE1CD+NklX6AHy0NR25euGYu8fkJB5rtEqQcwV36/UsCJqUx8EUrdLo
         DZrKcU5+KsH9l3EFhJvvyenYodGm4Fa+f8+MEr/Wzru4LEwihc8qhJa2HJVRvQI8aNBL
         ZFjBeF+sf6iQICz20/p4Sp3PwQY2PBjDXuQGvqaTkAKG33EBf+Oi0xuNwGnWCHt17TjU
         WauA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6WNGRBYRRBYoTawwIB+3TaOnj5eJ8+Lx1KC7XXOnbI35Fc3D8PjYWDGepUPL1S4bbY04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmOhGVEjnJUYpE+5EFkMDWxyImcnd4ESEgTcnwFAM07h2C9uOU
	CldhThgjcsOY9LS6vgrDn3lho0mgd8fDhweDNWJ+72fVmDI4HT/kz8lVx1O5u24ol91EJCNSIHk
	YbYnRaSjWONDLvMdTBzFiqcDD8xWvZsM=
X-Gm-Gg: AR+sD13aNTRupcvPP6TSqjNNimfwuv/TLy1RIxM1XzX6hVBJEgOnfVG95dnj6wxWrsC
	3b6CVMrv1K6UMkmwP4XM3wLyFfG62xvuIQdF6YI7X+wvb0lqP8GeWPZWoLflq6Hz4yDykWSZTlg
	DZtNmljNTjCTMM0+ONokPAFsDGqzvZzA5BzlR9MPD9sllTU6wpuJP9oSDfJYqPRA8UQ9giQM+yi
	TlTA0Led5E3N//8GaFTJNqDdrb7UEoN2PNG111QSHZvJXgh/rb7p0y6Au2YLIBQe1rv8bziX1IM
	Bz/peLZfA8iRwU6w8nN1aWH/qD/iVRKQOmgSwsNwElui6e6VfZ9kFD2CBtmyNyilfOTid49L3TQ
	47RBgdc+3hmcEvk8dVdpgEsORrVKx0WN/zkKgu6rzBU6ijDNsZpGG58ocPw5v
X-Received: by 2002:a17:903:1b43:b0:2c9:d298:6c0a with SMTP id
 d9443c01a7336-2d0ca9ab066mr333546215ad.2.1786341646217; Sun, 09 Aug 2026
 23:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805145949.938505-2-phasta@kernel.org>
In-Reply-To: <20260805145949.938505-2-phasta@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Aug 2026 08:00:33 +0200
X-Gm-Features: AUfX_mwcm7oQ_Y3CUbVf59t9d9A6DohexL7x3OfKArvNRPUGCPEC33TB28La-48
Message-ID: <CANiq72nZ25wkxVHpz9GTA_m5E_vyBmRKdDSUNMsJAZ=6zk=zhw@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] rust / dma_buf: Add abstractions for dma_fence
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Lyude Paul <lyude@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Asahi Lina <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Eliot Courtney <ecourtney@nvidia.com>, Mirko Adzic <adzicmirko97@gmail.com>, 
	Timur Tabi <ttabi@nvidia.com>, 
	Daniel del Castillo <delcastillodelarosadaniel@gmail.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 5:01=E2=80=AFPM Philipp Stanner <phasta@kernel.org> =
wrote:
>
>   rust: types: implement ForeignOwnable for ARef<T>
>   rust: sync: Add abstraction for rcu_barrier()
>   rust: error: add remaining error codes

Applied (these three) to `rust-next` -- thanks everyone!

Please note that your Signed-off-by is required when sending a patch
from someone else:

  https://docs.kernel.org/process/submitting-patches.html#sign-your-work-th=
e-developer-s-certificate-of-origin

I added it here on apply for you -- please let me know if that is not
what you intended!

    [ Formatted comments. Added the submitter's Signed-off-by tag. - Miguel=
 ]

    [ Relaxed `'static` bound and added `#[inline]` as discussed. Added
      the submitter's Signed-off-by tag. - Miguel ]

    [ Formatted documentation. Sorted tags. - Miguel ]

Thanks!

Cheers,
Miguel
