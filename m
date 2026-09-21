Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1897F3B71C7
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020457; cv=pass; b=h5Q8qiwemHW/t5S4tnbtaMW6kYqN9pfR9eFMrHGVYWDGENku836FIor565RH9RFWaaRf5jf5PB/Cq2XCAFwYoos03NOnEEMZCsBVJ5kjGAISejemTSn/Mpa33RXjazYfe+jOisGeYuy1E71YRkBwZ7RSbSZDOsoo43uvJ7mg4KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020457; c=relaxed/simple;
	bh=+K0x7Oa0SLCPC9/TMd/49GdUdR/oPlDXAf+dxWf8XbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ttx2pgPvt6yM5oJ0UrZRZOZDxru/ju9s1UmB0E7CliQ8vYxdZKte978gpOlHo9f0q4e4I7Y/lbtblHFFGQwJwiZl7jZ6qJ0KG4Ocav8HhMtCB9ngR3D5IoA/w1v4u+sjBtus2pqw28xvAa2YgyTI/NhKw7V02uB8GZEKe5XZ8yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV+Hzsxp; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV+Hzsxp"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa22408406so5171912a12.3
        for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 12:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790020454; cv=none;
        d=google.com; s=arc-20260327;
        b=kXbX2mitV12B16GkwtFilCjnFVfdH7/DPrB71QI8H+Gjov98/bYnk1ZEbHvEnQuJfM
         yh4hjQ+Izkdvj5uUiOfosf/tk3n8fnSebi1rMXssuzpx8e37F9gDwifDcuY812q5cvg/
         xd6NoWSd2qU+S+uxT4Y6LvonDUfhznsklzXgXjyJw4Vga4Vxi2BbrMiydqiOkUImMp3B
         or4IMO7csl/1VOftNeHLmcOh6R0mb4C370hjutnfB2N354hfTlra/QfAdOac7Ph3yy2e
         ysOfFcQSZNu9J0OcPm8TSJ1oZc7y2fgvcpkkRBbi9qbGh7kwJoWEo0aFvXZetpQZU+94
         safg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jcLPg4sxIMnPVu9DYBY2crfmwfHr/m7CBHhYvP1Mzt8=;
        fh=xWUhNQG7w5pZmrU7PHS4S/02PqWA0lqaS/J3eTVbksM=;
        b=OQvR5wjqVujHu996uO3b0ajNG8iWN2hJmPr87VIjmgiSJIx5vGBBG4xTXjtYQiFvew
         TD5O43Ds40qyyKWznEJoOoGtB3H15kIJIgnGc/FOwBPHpXdPTvQHRYFYyINFXwX3GxtX
         Hxow68zw54Wk2OGQzA6kONX0haKP4cN2FZne7zQOe90bFdUeKUkdSIQQJdbBE5KAFetW
         3nRYWx/mdb1XY5jIzabm++TxMGxaFqIJAJz36hntgf0v1L58JtymvnpHWLhKvKJtm8Bm
         HcKfr8YVFnOyO7nWzpLPz/126Jns0ArECSfzkVbfhrfiF0i7mj1++rKyutTtNchxZ56C
         K5YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790020454; x=1790625254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jcLPg4sxIMnPVu9DYBY2crfmwfHr/m7CBHhYvP1Mzt8=;
        b=bV+Hzsxp8aJpIjHUvEz/4JSdqYpl+Oen5Dzn+8rjtxhIwX6uQEwACdmarrIsm0iOGE
         ICsrUhONONoC1ldzQr56MaJRafTmWm5FQEr0yDaH1mxR0s97H3WzYYkXBDvkx0PaMkzX
         Mqxv9Td4nnX/clgV07Egt4TqedpdzyURLjjp6srrgBoOtrVbVdGVZPUJ5G93EkLzsL/s
         WH5YGB3xOzy7M8qs51zQVZ9upZXizEjBtCcR18be8LLDmtenBSwPT+fHF/hmMpH/noy8
         xgeFOLnyKi6H4wwt8P7aT6K/nxDIC4LPoKnMmJaHYqtn7S7lnfD1zD+nWFmU3/j1RYh5
         QKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790020454; x=1790625254;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jcLPg4sxIMnPVu9DYBY2crfmwfHr/m7CBHhYvP1Mzt8=;
        b=Iu46JFZsaSnj4l+KRBhzIsXC13rBCXb+CGhpMb3pdpjacZBQfbS/kNXbwnP2iYWOgR
         og/XAVZNJh4KktR0IK/v8LYJVhcXtC6M96r/i8u0ptqfAu2/p8MBKMRUN/ik1Im0DeL6
         0hl5QrC0xFmoCkOP/1F10+QRkQXCRE+IZv9Lo/PdvRLK7iFWNxLAx3Ns6jZAv/czJO3P
         xrkJmg8QntvDuKy5ze9wgbF25QeDTEIuangdTtRlKqfYyHJZMBTWrAvKoATmzr8x3scA
         LCS/u9Ikz6e7wkA8DCcCDhE5aGbd8Wnp/wCKGAetsNT+M59X5TA9wPj7el0BekdTae96
         VUiw==
X-Forwarded-Encrypted: i=1; AKwUvBy4yK7Cf9IlLS5psMeghTVRaEECgjygu21no02TuNa437Tea4CxwX6W2BjzK5yy+pX/40g=@vger.kernel.org
X-Gm-Message-State: AFuF++lAlSnCWI2LNLDuetrsgiW6xvERNoVlOG/02LKwEh4kjyq0eSco
	dRbRr1Prz0U1t1NI5e3Y5DtuWBUy8T+C+ySl6qE0csIm5DGm7nwyum/PCftnER9D8kjazzC9ao3
	knz90RmJYMzhoSfZ+wIkDri8aWsHzfak=
X-Gm-Gg: AYBFou2pcVERQg2kfEhYGaOOKHzswEMTegLPxHpQgAt7f/vnoNYW//SijoWJPQGxy/w
	kUxOKY5Bwg5I/xRaYuUtCXQ4unWInJuwMtXGQIl1TMwvwb0Eibf1KVyehtQZ38Kw1DGfCfsrb4B
	dp9Nq7zA7VBwTLGsgptL2nl0CqQtKWugymbl2QVBFlK6VaMNg/f/FbfwJJjaT98ZyvxP7mTB2bJ
	0+h154TmWJIY5idKZgzyjdGnuDYlQP2rpfzbcIITtb+zpAFQlGur51LRnhIpo2HK4pZpMFfaBiR
	m9UAwFF4EC667AOdGxUJ0PuKMsPGv8FKc/+dgLiVvXJfAKF39P9Ij+1tYQ25ZpPu0O/fd4h/pV9
	T1lyR
X-Received: by 2002:a05:6402:24dc:b0:6a7:ee56:8156 with SMTP id
 4fb4d7f45d1cf-6aa579ad808mr7351821a12.36.1790020453888; Mon, 21 Sep 2026
 12:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915154248.3612028-1-puranjay@kernel.org> <20260915154248.3612028-2-puranjay@kernel.org>
 <210f1bfa-e6ae-4d1e-a920-a6c8c9b4269f@gmail.com> <CANk7y0gzipiJrObW0fbh0gP2DgKeZAUvCNuvaOdJrGWgE81LkQ@mail.gmail.com>
 <ede9d515-a103-461e-8244-656af641c6c9@paulmck-laptop> <CAADnVQ+bmTPScUBfOtD8Sj9H8KjAqU2-XocFsP3G2qgNA7q_Pg@mail.gmail.com>
In-Reply-To: <CAADnVQ+bmTPScUBfOtD8Sj9H8KjAqU2-XocFsP3G2qgNA7q_Pg@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 21 Sep 2026 20:53:59 +0100
X-Gm-Features: AcwNN1WnN7QHPB5f7ZzrNkV-R4PXF9XQw_TXw_WLfugdc3j3gLzzQZ6PR4IytP0
Message-ID: <CANk7y0hC6kzOct8r1cDpRnXgvvqNqpfcn9JWOnicR+JisNc6+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Add bpf_call_rcu() kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	bpf <bpf@vger.kernel.org>, rcu@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 6:16=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 18, 2026 at 9:03=E2=80=AFAM Paul E. McKenney <paulmck@kernel.=
org> wrote:
> >
> > > >
> > > > I tried to fully embed structure back when implementing bpf_task_wo=
rk,
> > > > Alexei rejected that approach, because some of the structures (irq_=
work) I used
> > > > are not in our control and might change. I think this applies here:=
 `struct rcu_head rcu`.
> > > >
> > > > Link: https://lore.kernel.org/bpf/CAADnVQJy0tAj9jkLrD1cBFkLK-DayjG6=
uNGZ3OBQh4V5Zt=3DWnQ@mail.gmail.com/
> > >
> > > I agree with your analysis. Although struct rcu_head is unlikely to
> > > change but still, I will change this to a heap allocated version wher=
e
> > > we only keep a pointer and not the structure inline.
> >
> > You can always use a union, as is done elsewhere in some cases.
> >
> > That would preserve independence from the rcu_head definition, while
> > avoiding the need for memory allocation.
>
> In most of the cases kernel internal data structures shouldn't dictate th=
e size
> of uapi struct, but in this case
> struct bpf_rcu_head {
>  __u64 __opaque[8];
> } __attribute__((aligned(8)));
> is the right trade off.
> I cannot imagine how rcu_head would grow from here.
> Two pointers is what it needs and it will stay this way tomorrow and
> years from now.
> The rcu logic needs a pointer to callback and ctx. So two pointers.
> Let's not introduce memory allocation for highly improbable rcu_head chan=
ges.

I sent v5 with minor changes and kept:
struct bpf_rcu_head {
  __u64 __opaque[8];
 } __attribute__((aligned(8)));
