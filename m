Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425D217F7;
	Sun, 26 Jan 2025 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737918956; cv=none; b=cDUnNH4v8t96bkZZFFSq/8hdqv0Kp4mj8KXIwztBWpluSTfExfW+C593H2ZGQ+lA99WHCnY9SH8MRT7r9iGbKs5DOGhMihsUubfqgcVUfiMDB1FHluKM8fIFdEWzLsxOtoG6GxNrj/VdmUBztlIZQ+m+NLoulaSayfayHjfXFsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737918956; c=relaxed/simple;
	bh=UPF6SmgIy9a8xVdFqgBHiWMyk7YU9obpQrulR7785Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P15e8y5qRebc8ysIF7ruq+ge0f2E7bZP1tp3RGoyfHwaOTuqp4J6WzO3ZK3ptJQz7iVbm3fN0sg3x7DyvdJ0aI5WRG8HkUreY9+fjil1kFCIh7ZOlO00PDMDWql8jM0xzygjZzOvRBB7Y14WSlCQ/DnYhfV3VejVAmO40mbfR2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOLP02Vd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOLP02Vd"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab68a4ab074so206324566b.0;
        Sun, 26 Jan 2025 11:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737918953; x=1738523753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UPF6SmgIy9a8xVdFqgBHiWMyk7YU9obpQrulR7785Fg=;
        b=eOLP02VdcQiO+AaTDAzpWz/0bX+qDfD721+TLu+26mRFY9N22NCTw4CvNhMw50mqhW
         JdYeCkOZQw03mykr/TE0PefHwWyq2kyNflRpHcWWPGVV1eL/OEOYv40803K+KCxlQUVK
         v5Ee3Jgtpz0L/SmXdy09hiY3rF2UnGlYNWHmhExmvpggfD1MA6LFDEEOOTbHgoRhdnpZ
         TyIWjgW3vPBuCmCM6OTy0Im6blZQMkgotirx2RwR9/Kzre3ChOZ0HjzoIwjsTubo3UOq
         0VQU2dhxIbL9Vp1Slg4e6NCVpMAsa5e7OPpFRQTXAshsTVjewhsOBzDHM8YHD1HXyhI3
         Pg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737918953; x=1738523753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPF6SmgIy9a8xVdFqgBHiWMyk7YU9obpQrulR7785Fg=;
        b=JiVlKut7vVeK8/DQaI/AtAMBGvGsRapDW8b0wsS9M6MpTvYW9UH/24zi4MWvwUe5DZ
         V1sMyPnK6BjYTggg5Jd6m3OsZLB+LPee8SmGrUW0wiE6yZNEuvVkULlWALssBtnX3TR8
         C3NXtDb5PulbxWzUoRA+pbZRrKfCWQaqhU5oVJzwg6j3C6qzvb6ma06qUCiBNG5yaIQQ
         7vulxTA2dvtwgH7kUpv7to454ebk/HodAwDM0hQTJzJJrjVmPimVVebIHwNeHKJ+vCIL
         w0D2M2XzJaH05JqSAO0dannhtqfo6Q8qzKc+lsSa+cYn2iLWeon79EOwMijlpNfBZzzo
         slFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg8b2q4bXv66MA6vwIP6AhAOOTwxQlmisEYRMX3mSOOHZMlT2/v55VXjlVqIQwpI/MKk+E@vger.kernel.org, AJvYcCUys0pw5KyX4SutrwE27O01O0mVDG1i7+x8AWMm04VIhwzOD0z2oV08XM/G6pQVST8+9rwUycj2zBU6tA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEt/0peslVeUZSoQT3R5JR3HYNQk6lgLHjVmLMosA+yHFvcn5F
	OELxT/4gqlT1vruzmW8pXvG0XeTKTWwr54QBlNoZj/KirTvYHnoBDf8GCIDpBd78B8Uy5B4ZCwO
	7Y9n1FAf6jHFMvRvRNMMS4IRbnxI=
X-Gm-Gg: ASbGncv5izj9sqp1JMgm0E25LY5Xhso3ah/P6o1DCF7U6qyOZfOWoJe3bAvcY4M6WGm
	du3m+V04sYX0kGvoWKX3GKaMOZYC0724pnFfGbkH7UbzaTAQJA4Z/i8vxpM8upOw=
X-Google-Smtp-Source: AGHT+IG+wHl1DPmcbsl3K+lsZmVfCTwk5Tn8g3JUT185tsQqAcGbtrsKVhQ3+etfkJUA/SCBTSRaq6ShtN7eEcHDSVk=
X-Received: by 2002:a05:6402:84c:b0:5d0:d818:559d with SMTP id
 4fb4d7f45d1cf-5db7d2f5e2amr97067894a12.11.1737918953364; Sun, 26 Jan 2025
 11:15:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z5NxuIFsMUvqWUtC@minute> <CA+=Fv5QmSkP4Ysp1zHNmUPftXYbSquTCsO_o3Rcgi2T5RcPj5A@mail.gmail.com>
 <Z5UAFAD6xCSpKJYw@minute> <alpine.DEB.2.21.2501251543460.27203@angie.orcam.me.uk>
 <Z5Uit9F7xF0ZlMk2@minute> <alpine.DEB.2.21.2501251806280.27203@angie.orcam.me.uk>
 <alpine.DEB.2.21.2501251839440.27203@angie.orcam.me.uk> <Z5U__sztq2P2UKWk@minute>
 <alpine.DEB.2.21.2501252129060.27203@angie.orcam.me.uk> <Z5Vtl8PzOY66bp9K@minute>
 <Z5Y__QtiySs8UeTK@minute>
In-Reply-To: <Z5Y__QtiySs8UeTK@minute>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 26 Jan 2025 20:15:41 +0100
X-Gm-Features: AWEUYZnUTdVi9y3cp5SEs8V5h4S_4SZrca76m7H9w3Lw-IAsXtXJ0OdXGLh8Fx4
Message-ID: <CA+=Fv5QOxs4mp0CEiyhFQJNxunye1aJMXDSzZ5U04QeQEYzt+A@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: Ivan Kokshaysky <ink@unseen.parts>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Michael Cree <mcree@orcon.net.nz>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, rcu@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I've applied the patches provided by Ivan, so far both systems are
running fine, compiling kernels and such to provide some load.

/Magnus
