Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7E131D371
	for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109133; cv=none; b=PCSXqjqgucheM0gaetpt8rfORyoYkKM5xA9riaVGu8+cnNks/S09wUvTmZwhlxm2mSjYZDmCmgzyo+EmTzS0Ww4FBM3ArzloWlsedCoQWEoAGgksXGys5UA3mGwzF6+B/Asn156ScRYXtOl7jt3RUTIJF0RDelSbu7F0iEr9g20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109133; c=relaxed/simple;
	bh=HPNedq15vNiqgaf0YXo3hv8PcvxepsSVlHVp/qIG2qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILdJMy7JrwQmaTyuZenTSS7v0TnEvecX5geuD2wuR36EFYFzOm3fD63Tqa0wvNLKxgODX99UCYr2HJOeWULqj6uIriaaP1V2y1ic9M94ARU0zTWSC18iKKCgfJTyHL/EC04YJ1Y9vfkxVW7xoGo9dW1EwPgn1yLLFlXjdmmYBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xy8+W3hS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xy8+W3hS"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-671dad7cac8so100640a12.0
        for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 12:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776109130; x=1776713930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R5Tv9X/6ommKr0zoXLOkrcOfgZc2rsc84YMEXIMzwQQ=;
        b=Xy8+W3hSpk/ytsJLBTihTsRb0OGKzazJKPHLlYBfK5NSoW8qv4yotMZYCD22X0NdzP
         /vP9wbKgRn5KJu972kZn9EOKd+u5Txs3WcmS9Pgi/GvOxbRa79O9PZBzsjOMy/BgoQSC
         0WtCJItKLM7guD0oHN28N+ZaT8KcgHGelb4q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776109130; x=1776713930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5Tv9X/6ommKr0zoXLOkrcOfgZc2rsc84YMEXIMzwQQ=;
        b=UWlNdptkq/R6Vvbk0kg0rrr5uFQbqG2SCzbGq31cK30Du/M/GW0k2XmiPpL0w2e55Y
         B37Bv7WgSbAT4UWrKiQ3LfKd2vMxmYEedrpWHV+5s+C3okAR/laYCUuWvuwfjDivWcng
         18ZzLSRN9z7yS5B3V7fV5kppu4MoUcq/IxNiMKnm7ozo4WQMZ7c6BBYo2FDiaxsW/bQK
         B0RaRFN3L46QFaQyfPkz1ygHaI3NQU9mBv3+ElIm38l+KgWG2W7Bl+51D+iuCCvKmqJd
         tQmtRWVmvUTLyuVFZ4/OkebXnAYPI06s9v8/poLqvCOQuwdEjciB4rUuWDxtTDAUPvOZ
         GkHg==
X-Forwarded-Encrypted: i=1; AFNElJ9Gb33DuQY7f3RyK0gLvPhep3DpgCGL6xoGkP7MxmpUD0UYMWCmxfsAf/D/UW6qfi4wIlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe7aDSvFnNJFfS2qB8EvaGs3r8veyWQACUzREI3IEGJFUf+LSn
	Z+Q4s/9dkJLclfn6Uz4+p1xvdEoTwknq0EAE5+pEFqj0p9x9ZeIGmOdQIwNK+AEHR8yt30rjYpv
	kqjn0ABg=
X-Gm-Gg: AeBDiet2jvSn2BUxBlbpnJ8MAblJl6oYMocKRaA2/2rvcf8cY5p9wEaCZj3Yl1IKMKK
	hNQJmTdQsMrYkudZs9d0s/VxS7PXXBki4fl3PwV8A3Y/ERm3grgMml59DdbLE+bflg53jnJNVNS
	pAgo1kWdMq6ymksXIHunf0KKppvHR9F63T1bvNVv7OzXRB5GZvrQRDg085dQMvQI6lZ6ondeOhf
	fcR06CKrCt61QcjMxkmSXm9Xskd8hoYfVaMUiATSiWwNwEESJ5wG5zoV6jyyswXaVwhg1Wbm4N2
	GbZk3IaV8CvOpURWIutRxEKkYeBLe4F8vSVE05KudrZN1Prv713AenBZhAUx4ZglYdAAGkpFuBi
	sRUcN7TEykDeO7H01hnq5fM5QOvk4OzsPN456/Zj6UsA3XIoKmkVZnXqLJWngxfzjyMVpr85gPo
	dKEeNJUpwcQ8O88SOGooSrFKlJqPzBVJ2L7q1JJkSOBTQZSXAP+/sbPtbCdDqh5eOtLNrx+OsG
X-Received: by 2002:a17:907:3c89:b0:b9c:b808:4617 with SMTP id a640c23a62f3a-b9d72499227mr910027666b.7.1776109130039;
        Mon, 13 Apr 2026 12:38:50 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6de97e43sm350307066b.13.2026.04.13.12.38.49
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 12:38:49 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b941762394aso585043766b.1
        for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 12:38:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9tSjxXeH+9xbDSXiIX4x/1RA+qartNgko5ckQ8e+RABKo2TuDGRPpqovolyk3F6xYgm8o=@vger.kernel.org
X-Received: by 2002:a17:907:3f09:b0:b9d:f6e9:91c6 with SMTP id
 a640c23a62f3a-b9df6e99932mr195804066b.3.1776109129095; Mon, 13 Apr 2026
 12:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1774978730.3972500.27807@nvidia.com> <CAHk-=whigg3hvOy7c1j1MXFy6o6CHp0g4Tc3Y-MAk+XDssHU0A@mail.gmail.com>
 <cefbf713-0b88-483e-89f2-2589919adb89@paulmck-laptop>
In-Reply-To: <cefbf713-0b88-483e-89f2-2589919adb89@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 Apr 2026 12:38:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVy8iHJxmkCrFggEtBrAzqXTm5cgt9xcKvrhFoMzhD+w@mail.gmail.com>
X-Gm-Features: AQROBzAAfwRI40yfUgzcciOplSL-UPXt1tukIpB9LzoPulRfSmCj_T6Iuq7Z4NI
Message-ID: <CAHk-=wiVy8iHJxmkCrFggEtBrAzqXTm5cgt9xcKvrhFoMzhD+w@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v7.1
To: paulmck@kernel.org
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, joel@joelfernandes.org, 
	agnel.joel@gmail.com, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Apr 2026 at 11:03, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Apologies!  Would making this instead be a kernel boot parameter be
> acceptable?

We already have a sysctl for it, and you should *already* be able to
use a boot parameter for it with just

        sysctl.kernel.panic_on_rcu_stall=true

Not that I've tried it, so maybe there's some bug somewhere (or
something I've overlooked), but I really think the whole kernel config
option was entirely redundant to begin with.

                 Linus
