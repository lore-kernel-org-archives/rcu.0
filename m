Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FA7361665
	for <rcu@vger.kernel.org>; Wed,  7 Jan 2026 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767806678; cv=none; b=Z4EjkOTHSbdiYIfivluKxTj2YRbXqipaufQGppzlhhtA3t/ElbLT1oBI+O8d82gWzQUgHaK0uZMs0FKzy2PFjY60wedMxRy9LyOUKD1QuWKE/3nGs6lUKLZb2YVzC6UlfvOZR8mzzKAC6tG/HeUYV3uDXnIIr/KhchoAcznpv4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767806678; c=relaxed/simple;
	bh=XqdCPkDx31P+/88ZI9oqnb0Z6s4jrFfvs9pYpKRo6yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEhE5huHeb1ynSjsTZmtD8Q1zCJDa9nMvfXZb9NyproK8YnCZU1GUvyNTLaENlG/UcKf3ZXu0Qj26Lp8DTdHFSRF2X5qkOjmgRPKwEn8Cnf6lhP2d3poMVKHR3mCGf/AAObszt9m1m61itljcE4HAb9Tf/RnjH97w0KOQbB5OGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW5A1LXm; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW5A1LXm"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2a49022ae5dso121042eec.1
        for <rcu@vger.kernel.org>; Wed, 07 Jan 2026 09:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767806672; x=1768411472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqdCPkDx31P+/88ZI9oqnb0Z6s4jrFfvs9pYpKRo6yA=;
        b=aW5A1LXmNeNADbdSRgXKnUuGmfIoqMFu9lALasol6jgp0fYY2RYeXvCCMoZHMHWnMg
         m8CbU+1LiHK5oG9KvKG9s4IfVGSbsGIh0CtU1jOkXmLXLfmnyFbCwgFR17R7eHfPQ4Hy
         9bkXsFmP4nXZ2pXesGPOen7kLOr+amPhToxF5qefGNxW3vNaofVM8rc3Gmypr6cJrnUw
         lYOlcaNRZt1guXycp2VrAqAzP5Xs8I8strkt7QcTcYS9ekc0Il/VodGK+4U48fxDwJxF
         ueqEMUJH8YNQNcFk5rAZtGBG5QGNKQ96ziPQrpE3c2IdY5R41hP2aKewX7xAhsqgZoT0
         3QXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767806672; x=1768411472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XqdCPkDx31P+/88ZI9oqnb0Z6s4jrFfvs9pYpKRo6yA=;
        b=gIXWlr/pAxMfCtGmY/ZSLl63WLT2n0RA/UqAlVIj+yXD0ymzc5DyonV4N2/N5GU+5Q
         eyPG1Gdi5aPfsaSWccx/WOOCN4+R9sr2YLQf4423amoLMhsPGU+vqetjX1ErDqSLXswV
         1oJvggG0Nm3yXdbDOb46bQeWZzHypuNNXTcgmhxJRV/ENL+S2hG3GO4dZB5c9HkpkL4S
         ZTtQwyf6R5VwtZVCAopElTHh+lm0y6jQr/dy+45wryIoGaTU1Y4XrDYSXsDVH9GnEyqu
         uMxpkFdCcqr5lXBV+3QjrATLKQST61w7MSCAoy6BHtorcBzh/cJezzU0SO4FJhe05c7A
         ftew==
X-Forwarded-Encrypted: i=1; AJvYcCUP4nOyHTs2hjFID9QnQtXKxosQ41AS/rBR+ognfW8vjU1fZFLUizIhOuxjpchF4by4wWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVXBkTLp71iTovNNw3RwD55VbsxDVI0vU0zla+eCefCnKnLAc6
	NRqvFNwvlTHb4KpkXezipRBFxyNU8gxKXVZ/0GilhASt2nJpG1yMLPxe0Y2bN4irFTv7AjRPx6R
	K0b6W8o2QxJuh/wcIsvwuKnPS5W+RUJc=
X-Gm-Gg: AY/fxX4f+068OgSVCLRbQ7SrNqjAqJ3N9pR1+PC9elrPCvZClONIHJZyK5EofuyxCSj
	Z/+bJDlRDkdMXLcc6JdNdSlm++OkuOjryziohKjT/5Ici4Cdc+iIIkFJ+9OG4he2p50IqNuwLXI
	l/ZVOHXBhuogpD674JPXYHhNz02B1dkMxdTSovXh9LpOoqIsO+vpiPW0GwglUKlqZ6H9coob1ha
	aFSaKjbx767iVjOcuR8NBudam8Hza0KsnpoRbfn7qPyz2whx+VZZH5TDP4kkflRtjOYYbipOzsy
	WPYLZc1J/eq+Xvp0i5bdn9mL60lJYYA9bYEyBx1p6UuUS5ZDsa/E5QOrNxHXspOon8DRfWseZV7
	OyUTi2Pyw4cEL
X-Google-Smtp-Source: AGHT+IEmNxe4H46v90z5Qsg81/iqvWHE2i419t6wujoy5EZQVIHlyBEXzgh5s/UfED7pXNr75mh1zoYiP0dchnOTKuI=
X-Received: by 2002:a05:7300:e58b:b0:2ae:5bd5:c241 with SMTP id
 5a478bee46e88-2b17d33c615mr1278675eec.7.1767806671760; Wed, 07 Jan 2026
 09:24:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5c5c0a4-249f-41b0-b5f1-87a58514b120@nvidia.com>
 <8822A0A5-CD4C-403A-A001-F4E7A351D81B@joelfernandes.org> <CANiq72mUCGL3f=GAYSZfMV1=NXpOjz4vsV7B3Pd-=EG8tmWC_A@mail.gmail.com>
 <39e74621-aba6-47eb-9935-0d2321c56d6d@nvidia.com>
In-Reply-To: <39e74621-aba6-47eb-9935-0d2321c56d6d@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 7 Jan 2026 18:24:17 +0100
X-Gm-Features: AQt7F2rzlYOZPcNPb5Y3stczaGAhwYq9zU0rJFqAE7X1RLdvvhtO7z7v_rYamrg
Message-ID: <CANiq72=vcYkfZtgDfSZaHY=0PMOwc+XiiJo74pciPOV7nrN6Nw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update email address for Joel Fernandes
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, John Hubbard <jhubbard@nvidia.com>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, nouveau@lists.freedesktop.org, 
	Boqun Feng <boqun.feng@gmail.com>, Paul E McKenney <paulmck@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Steven Rostedt <rostedt@goodmis.org>, rostedt@google.com, 
	Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:20=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.co=
m> wrote:
>
> Thank you for the suggestion! Unfortunately, that would hide the company
> attribution too. Or require it to be in brackets along with the name. The=
re

Yeah, I meant it only as a solution for the email trouble -- the
attribution in parenthesis would of course still be needed if you /
your company want that.

> appears to be resistance to both these. I do feel fortunate to get compan=
y time
> to work upstream, so, on this matter, I have to go with the company's
> preferences.;-).

I suspected that given the thread... :) But happy to sign your key if
you need it in the future, and happy new year too!

Cheers,
Miguel
