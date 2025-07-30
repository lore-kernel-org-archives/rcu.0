Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEAE26772D
	for <rcu@vger.kernel.org>; Wed, 30 Jul 2025 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753899126; cv=none; b=pGSAKieQpkZjnji3QVuVonIpX1IN/rKzhOU/KjkJFsuH/EIK5mGIHZxsqaJjGHGiLOs50TKDWa2riCwH0bdtLeZY9hUzzqsyl0Rc+6ZoMfJDaFMRTYVhivanvqFLx4OUxy3L5G8nuW9yGzxPqC8lvJj0/zVqLCBjs1whwUCGjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753899126; c=relaxed/simple;
	bh=hoh4HkXnDmJqJw/WrI6ycq/Ao/21Hcg9bbQopwz4GGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ah6gFtMBUzE88d1UFSD9ZxiH7a1pDwarfspk5mcIG2CExkHFF9hecZ0ZIYkYfEftH/8wW2WE/oqsQukC5jKU4Dtmn9Exh19PRXRFBlNgbTwQWG56LZeOxCYv/e5oVaUr/F7sMVC86WPWWD35TXX4QAUhp9MREDJXsmxNLSWPwY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q0UxUWzG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q0UxUWzG"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0c571f137so17536766b.0
        for <rcu@vger.kernel.org>; Wed, 30 Jul 2025 11:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753899122; x=1754503922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PoKxUWsGJ0drWlCsSRpNM9dExZbd5oNyuJwK6uC033Y=;
        b=Q0UxUWzGwqfMIuoZ8ia9371iUdmG5QkVv0ubff3KLnGw7skICjGDRpfZO+5gMP9zxV
         UVaNhjOkB3NUDxtzpbnLSs4hl6u+g9K9rgvGN35uF+l1ohs2yvlaycv1KH2oJgGnB8e1
         3bOHFWt2jpXEXU9sdL4OhAQoJ+CtCDrzwc5W0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753899122; x=1754503922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoKxUWsGJ0drWlCsSRpNM9dExZbd5oNyuJwK6uC033Y=;
        b=bmd0xniOVfu0LA0C6dtNbfq7US0ssdC5RX2fOjwqYfvbZm+fmXqdDSlmFEqwC1KQbJ
         WZHXsSLovb9dYXkepcm+UiXm3Sl16fK4rXfWZr0Px/fTkvhR3+DuDDa6+7Du3xjfY7xy
         DzjOwwWOGd78jIfBfe7numvCnX+D6KAEB5hxey+LouQjOP+exrkAqDg+L+ULhUBRZe2X
         CjP/G5RPMAt6+AGYW5LqjddNJyiHWOyq6GqqMUBvKJFuTyXZenUH+xy8XL7h78BRQF2q
         jDeqN4MBEdthiPbeKd+sytnK46jdaDDiyMvOiJ/I5BTo1i8tsHhgZXMlTx01w5vZGddH
         r2SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt5twIjGL3GvLCQPFj/XrrDB4+Hc/uOdAcieNI7DXEinZ3iXc4ryR5p2A4tJqyqC50SJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1k028jLyhJVXv0ioG1tEMTomw5WA8+ufUEM4qQVjeqSKrBR8I
	fFpwpD1clXRWlSlw4TDnIUsqpgVoa4LffnZk3skmFqUDiHNVlgUctedDEQLzekAQiiJilH63s4a
	VLbK2rz4=
X-Gm-Gg: ASbGncvHX1GQNoM1d9peRVuxJdbxHYZ+FFKbHUOWv1POoceO+K19TYbeHWKHQfYxlhT
	0fC3JFlSwFUViGEik3eNXn+mgbOY5d6CIx9q2gQB2+MdaoW9kpaLiu0xCxzMM9m5s1PjGSGa+7i
	xzOjfZ4f2tfrMAzu/5N5/AEP5nmbix6aLfrLHPxDqQM0TzcGBtwpo7v6qXiWJRioL5OsZaPvVCn
	5OAqDaLg9qRngdYSht8oHxjpezorARP4OoRoWVr7BCjCie7tpF7xXciGtj9ImHL06I9FRumnaFI
	RIMqTvCYjn42Hud0y2Ry3YEFH+MwxBkhhZB8l6cnNvoafenOF/9eAf5oMqd8dMSe1DhOBQcXhoV
	sE/DMNGMNlF7J0023lLfMd3oaYVea2sTesLaLDoFEX4w3ueQ/VoItlh3Nhf7WlJ6UljcUf2LY
X-Google-Smtp-Source: AGHT+IH+WtuCMERv1E46fmTvO3DELL1b/Zbbx8RmlGkLzzavmV0+2g2z5RFySFHSic2XkMEIQu/imQ==
X-Received: by 2002:a17:907:6088:b0:ad5:5210:749c with SMTP id a640c23a62f3a-af8fd774935mr510883966b.22.1753899122162;
        Wed, 30 Jul 2025 11:12:02 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63589cab0sm771083866b.38.2025.07.30.11.11.59
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 11:12:00 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso97202a12.0
        for <rcu@vger.kernel.org>; Wed, 30 Jul 2025 11:11:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVy7+0tbMKPzeVM8wf5SuCcfCnpmhul4oN9fD0UbIlaWYHiv7ONGa9FGcuxrp6hkZfEOKw=@vger.kernel.org
X-Received: by 2002:a05:6402:350a:b0:615:9c88:59e8 with SMTP id
 4fb4d7f45d1cf-6159c885b1dmr2065764a12.4.1753899119478; Wed, 30 Jul 2025
 11:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726024605.GA17131@neeraj.linux>
In-Reply-To: <20250726024605.GA17131@neeraj.linux>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 11:11:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1Cjqv08fdm3T3ZSBGN2vhMm00Ud+JjbWthK0RygMF0Q@mail.gmail.com>
X-Gm-Features: Ac12FXzcgjM63YExZi8MiZ1Su9hIEpeaVi0WR1ZQE39K8u8IrcOTSogonMnM4a0
Message-ID: <CAHk-=wh1Cjqv08fdm3T3ZSBGN2vhMm00Ud+JjbWthK0RygMF0Q@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.17
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
Cc: paulmck@kernel.org, joelagnelf@nvidia.com, frederic@kernel.org, 
	boqun.feng@gmail.com, urezki@gmail.com, qiang.zhang1211@gmail.com, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, rcu@vger.kernel.org, 
	Tze-nan.Wu@mediatek.com, a.sadovnikov@ispras.ru
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Jul 2025 at 19:46, Neeraj Upadhyay
<Neeraj.Upadhyay@kernel.org> wrote:
>
> This pull request contains the following branches:
>
> rcu-exp.23.07.2025 [..]

I've pulled this, but I do have a request (or two, really)..

The octopus merges look cool, but they have the problem that if there
are subtle bugs introduced by interactions between branches, they are
a pain to bisect. So in general, I advise people to avoid them.

But the *real* thing I note is that merges are more subtle than normal
commits in the first place, and octopus merges are subtler still - and
your have no explanation at all outside of the 'merge X Y and Z into
ABC'.

Please write more of a commit message explaining what those branches
*are* that you are merging.

Which is the second part of the request: when you ask me to merge "the
following branches", the branch names are basically line noise. I'm
not in the least interested in seeing what the date of a branch is.
That adds no value.

So can you please instead describe the branches by what they do than
by some internal branch name you used. I made up my own "names" for
the sub-branches in the merge message, but it would be much nicer if
you did it in the pull request.

So, for example, I changed "rcu-exp.23.07.2025" to be "Expedited grace
period", which seems to be what that branch name was cryptically
trying to say.

            Linus
