Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10B5AD5A
	for <rcu@vger.kernel.org>; Sun,  1 Dec 2024 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733047765; cv=none; b=vCOQf77r9CshYr6SHC84cq5Z3siH8Oz1oGUFcnTLt+MZyIdU0dMRd4DwHXV/duWRWXQT4SE8tHY67yT5Sne9qAozCQfRsYEyDPSDUV6fv1w4n+8KLVM7hE3eOv3p2/hArI4yYr7PHYswKlPNPZN2v8x6lDwHkYx4QuZqK4u1ZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733047765; c=relaxed/simple;
	bh=gOi+enroUyrB38qJqbzPwdn5XFUcbaoFsaiQQjhidCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpN7Bs8YNXsZ1QTE4Qf8DxD6p3Ph/u18pHc/1ocMtO5eOSiKLvTAsHEaMJLfSL2rMJK91UdTzfJ5DrGX2qbYJhOdu7brM06L1z7sjZ2/aS22WZeR3hYhoaPXGElMGi7p+dr5H9q6HQFCnXZDkrYKRV5CXJsyMtCAIsb5Q1c6h6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmTdAbm2; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmTdAbm2"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa5b0d8bd41so326794366b.2
        for <rcu@vger.kernel.org>; Sun, 01 Dec 2024 02:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733047762; x=1733652562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Y/P4yLiokP4aBaqQz+6ev3m1YWo9zM+Q9ULiW2DX1g=;
        b=NmTdAbm240BBIC7X/r1iNtcxSW7UzapLcgiegGdK6mfENDpQH/Cfc8QQ7qZyJx5Jx5
         JZ7eorvAtWiVlUZx2i3LVZ9qOrrqKdoOtS0ywfsSBenBUtnTAbNdKx3vBniBLmnJkgdG
         QefvDUnax/vbgn5Yxi/Uuw3oR/sF5wnHtCTCmZU2bp7U+MT3t2NNUgc+PQaLQkV8QcHK
         ByyzZ7zWqYQNMocwHxqxI2PZs3UkUQkV7cbQJHi2CzPhv/lfyIU9j6otRMREAcp9RORe
         v+a/BJVekVD5Nb0MDchq6KceduqcEIVuAxFltjmWnz5Mlr9Wg8Dq6TFRNAtQO+VlKS28
         wVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733047762; x=1733652562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Y/P4yLiokP4aBaqQz+6ev3m1YWo9zM+Q9ULiW2DX1g=;
        b=FjnXIfp8zMZ5goM16uSmIHSmjuBX6S7zm9OqGH9L9z3JLFJveLd9U8JncPo7oLwWgp
         BlXAol5AfugDBJWLt/fgBOobvI5qrNgBiF80zyr0yfxYgrbgod1Jyqfzgyqb+APFmxIE
         0J9hd0ywVfh7UEBTRq6a7hHtwgOuWXfZjqtO/FZHoYt8X1XQkAeTNLJNn/RenSI8Bn2c
         rFwdxvzVVR++U1uBdozbN821fKcUa1jwpuD8oPafY4eadCvJcIcJl+n8iSbJRSDmw4At
         qDRlwkGpvhmfHR4C8qo9SC4ORzd9nqtQx9NOSmUgg3gJXnzLpIw0oePgDMb6i5jlL9W1
         ig8Q==
X-Gm-Message-State: AOJu0YyLY/I3D0f9em2Ywu3yiNLcT9uw9yFwNpfHo/ncuQXKiUUaIlmk
	yKOXHPZBetkUYfXWmxM0BBy8OL0CiYcC4eZemMgexQek3XpUcNDhJmNzSOfwptZuAmpAuLDTdyY
	7ZWBkzetSlMleN9jDZwLqb5+RbXU=
X-Gm-Gg: ASbGncuu7FShc+mFyNLDg6mH4D1noFDmCxoJJC7zR0/hiCBcdaHC1MVM1dV2Y6kmdpa
	qf8qmZa7jDeepTweexzC0HiY4TvE5hZSi
X-Google-Smtp-Source: AGHT+IHaDlQeaQmlEoD98gou9QFDqWyvMzcuExnVPb9zlUrCJc9gVwFDcy1CCXulqImOFxrYWdJ1PYkr2upTI1L5Xg4=
X-Received: by 2002:a17:907:7743:b0:aa5:49f0:1510 with SMTP id
 a640c23a62f3a-aa580ee8739mr1333981066b.8.1733047761938; Sun, 01 Dec 2024
 02:09:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+=Fv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=Ei90G98ukRcRJA@mail.gmail.com>
 <f1561626-fde6-41c0-9d45-87a6a7b13816@paulmck-laptop>
In-Reply-To: <f1561626-fde6-41c0-9d45-87a6a7b13816@paulmck-laptop>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 1 Dec 2024 11:09:10 +0100
Message-ID: <CA+=Fv5TMZ1bckob2VZ1AaNwdU3R+5a8REKg4aZR8novx7+dj-g@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 1, 2024 at 5:31=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:

> Does booting with the "rcupdate.rcu_normal=3D1" kernel boot parameter
> also suppress the problem?

setting rcupdate.rcu_normal=3D1 also suppresses the problem. I guess this m=
akes
RCU code not do synchronize_rcu_normal() in stead of the full
synchronize_rcu_expedited() which is where I get the kernel Oops.

> That "pc =3D" down below is the program counter?  If so, I am at a loss
> as to what RCU could do to make it be zero.
>

No sure why this happens, if the RCU code is passing around pointers to
worker function and this somehow ends up being a null pointer on the Alpha?

/Magnus
