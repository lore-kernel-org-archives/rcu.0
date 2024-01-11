Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE154BC0
	for <rcu@vger.kernel.org>; Thu, 11 Jan 2024 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIo7DLjL"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28bf46ea11so989729066b.1
        for <rcu@vger.kernel.org>; Thu, 11 Jan 2024 10:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704998119; x=1705602919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XckDBo3x22KtzYvvHy5aELzSCLvTKx3LV4vOjBqqy0g=;
        b=SIo7DLjLOg8r3J9yNMtYCmDbf6J0HigaJeWHWZTiY1KRIFCr4xGwmFnaSH40x0gUDj
         YTPQm/cZt8g1M7cvdimRop5qB7JiapuXFsWxmSj7e9c71oQh+L+Ad8a3YHe+2MCVVUpq
         NH8qq/fehWErwUfbCK3cqnLz1shsjPrucRTvN8fPpp47B6B8KJd4NQZQlLDr8oqK1+AU
         5wghgAECcD0tL0cAfeY7mPIqc5wcPuwL8TSbfH4h0N5b5eKGmARMeLN+xSmMLxwQy/m1
         p1IpzLuhthWRePGSSoNySnBGTPlN5lvINY2aXMrO5oxcbAKPeOfvzm2Bx3zLDZnU3rwZ
         /rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704998119; x=1705602919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XckDBo3x22KtzYvvHy5aELzSCLvTKx3LV4vOjBqqy0g=;
        b=GjZW/sl8LJBAz5Ye1kcQdGwVbZfj1RU5cJVUK1X7GGMMVALGSF8dkSx+ADB/xPTABP
         BeBdSaLy8YkTyKu4MF2Cb3YRi4LUfn1MUNwkhXKldu+0Zm9W5GTb8OAfhYfnzaMluhDB
         rmVsa/ZToCq2Ph2bssaOj99zrYi5a9duUJhm+6kdBqu+STagKAdsENdlFR/9lSv7bRx0
         GzFBh6aGihi74iaAr4ZRIkL9W2vnHj/f6aMH+ez3Vhq0WRnu5ryer1ERik2fUvQaZM10
         J1P4NyEJk8g0Na5ZEUu5q9m51/k9tCVsbSFOK0M6o2QYSv/X1U9J4VQjOIk0U9eUehH/
         J58A==
X-Gm-Message-State: AOJu0Yy99I0yYzQWtrojhRxredRkM8wQL+QrCO2/N+WC0KRfRCZSPBsM
	2TLVO2PAXiYcH4DMBtSo1SQWcIOqTGGOowzG0u0=
X-Google-Smtp-Source: AGHT+IHjdqs6rKIIrq8ejt0F2Vsy7jIIDUTiCeD96TT78W51JuOQq+93A02npx8qkifKjD5Cx7oGls7eDhos+vFFasA=
X-Received: by 2002:a17:906:ae87:b0:a29:2668:7bfc with SMTP id
 md7-20020a170906ae8700b00a2926687bfcmr303844ejb.65.1704998118679; Thu, 11 Jan
 2024 10:35:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a6d4007-e783-4dee-9f0d-6a1d2525a766@paulmck-laptop>
 <d9bab0d0-02a4-4220-88b0-3f9a86512bf8@paulmck-laptop> <f54b3cbe-181e-48b1-bd68-3eae64940046@paulmck-laptop>
 <bebc98c1-286c-4196-8f41-50d41b30f031@paulmck-laptop> <CAHk-=wjVU-r8+QTTy7Hw2KXppnwU-8GNbgzw8YbAwJdsAZPr8Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjVU-r8+QTTy7Hw2KXppnwU-8GNbgzw8YbAwJdsAZPr8Q@mail.gmail.com>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Fri, 12 Jan 2024 00:05:01 +0530
Message-ID: <CAFwiDX9dsgVkFXNLVfWd2EJa-UkDJaD85XNzeLdaH3x6bDNsDg@mail.gmail.com>
Subject: Re: Neeraj will be doing RCU PR for v6.8 merge window
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, frederic@kernel.org, 
	urezki@gmail.com, joel@joelfernandes.org, boqun.feng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Thu, Jan 11, 2024 at 11:48=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 11 Jan 2024 at 02:52, Paul E. McKenney <paulmck@kernel.org> wrote=
:
> >
> > Just following up on Neeraj's RCU pull request from December 23rd:
> >
> > https://lore.kernel.org/all/20231223021434.GA2714@neeraj.linux/
>
> I do not have that email in my mailbox at all.
>
> I have no idea why - it might have been marked as spam and I missed it
> (in which case it got deleted long long ago).
>
> Or I might have fat-fingered something, but none of the contents give
> em any d=C3=A9j=C3=A0 vu at all, so I doubt that's it either.
>
> Neeraj, can you please re-send so that I have it in my mailbox, rather
> than go by a lore link..
>

Done


Thanks
Neeraj

>                       Linus
