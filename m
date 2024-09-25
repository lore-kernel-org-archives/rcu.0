Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C404F183CAB;
	Wed, 25 Sep 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727269017; cv=none; b=Ig1U/X79+bXkR/b7PuaVVJkR7Jgoj743aSvAcTbJRVNDE/9Nf7/YrTb7CmFpSCuZcojSJ/FZR2UPFwXV1STSq6XPBj6ol5Jufp2WRcwViLWE2+b+oKXIvNr1LXGMJTLGOtImCOOJXo+i7PSWlvzR9VR6OdJ8xrrqQ4437lXycHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727269017; c=relaxed/simple;
	bh=3fxAT9AVfLIeN6rjTVrSeohwxgf70dKlprguYeTQ+CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXxoow4VtsKRpQwQ50BRBLGDcsuRvQvWCU9SeiKXFFB38QvPcL8cY0uvu0n+JsEq2eV2tW3LNnajlxa1Vi1CNif8i2+ZgYNkEc3gpoStFDPWkHHrG3DaFM1YuQjTwHWsZxk4fI0J4XXkX9j7mCdY89Ta/oqzUIq2Zkkd2iTqxEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m55ZZCs1; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m55ZZCs1"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53567b4c3f4so1132055e87.2;
        Wed, 25 Sep 2024 05:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727269014; x=1727873814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fxAT9AVfLIeN6rjTVrSeohwxgf70dKlprguYeTQ+CE=;
        b=m55ZZCs1D2duxSFZpFnRMfPKdwamvYNZ9hUrWqC8wtVNWQj3KJOVc1eFBRBbzF2Q+p
         CwF5tW4SmRTEwqz8xl0DT45Fil465vxPJxUJA6PFF3BvcmNgJjlvfmozJ4MOzN7T+5/S
         oastcsO0JekNwCSLFW+nGit+3w4Fdg+eL6W6jvoQQEEXjE6XCAlovWbGEqtcn1m45bMR
         038DdWZPMu5DRid9PgBQuDUc4dK34YqOUHwqBoJLPvnF9Ip+GLgWqq9drvBEJfOTo7Yl
         859HrtWWgGxU51Qd3kxtLZICD1wlxYumnxtasf2TttptV5lGZ50PTEzZeyb0cu4Y4c0R
         JspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727269014; x=1727873814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fxAT9AVfLIeN6rjTVrSeohwxgf70dKlprguYeTQ+CE=;
        b=I6iUAdZ4S3gzX8YDgipb0+av1csZfM4MI9/knt9z1VMJjE7SKzip2aAU6o5jGLey/0
         fZd4pY/2XM5eTGyIIBbtLrUbsL6Bxq7jcPvMMXe6ewPGO6P1LsOUn9L5IJqprO3f6Nbu
         AUlIyWE09XcPKIEv318qwy/NEH1SqfGTJ4AbGm28gTzHt12NmphCOr2FBSqHmUYGOppk
         2LPlP785ZhN1fW+7KmQF+S/hHxoGWnVIUCsQ2Kr0itMrvbGcW0cHm6Qr2b9+Cz/lV7gM
         FnTCjDbOfuzwmNCIVRUhM4wo77zexZjMkzSi83rNFUVr3rX4Sacl51KQmfVRqTJ6KgV2
         7Pmg==
X-Forwarded-Encrypted: i=1; AJvYcCViwP8zK71D0r7QRdRvBvdnySBoh8ro70CjNCMcdFQgF40GSanQr8aAiUCiruAA9+pf4Gm9scCLUmcUAHI=@vger.kernel.org, AJvYcCWnxfHRNz6DLY3yfTe4FU80tbteo5ROfRIu0cMknp8ZwGOZJJLA1Owi6i9z1l+EIw4U7eRb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx7zkvhF03VHuv2w5oNh907g/0kP28VVcj0aZE1NerkWDjCkeK
	gPMK7Zg++Cn5RTfSR6lIBNZaSyvGDke2+c5TsDAo3PuB6a52igheC/dyO16VfZVDrl5TcNiQBD/
	Nll+G2T4Fls0uDMzeia/sNO2FTIbrJ6X0R8k=
X-Google-Smtp-Source: AGHT+IG2RdlFyeWRvaEGDdt+1AxrtErQa9D9ipkPti5nYA90xXjvvPF2uBQnA766jIJPAMkrSvh2PIdI9Qj8zx/I20o=
X-Received: by 2002:a05:6512:4019:b0:52c:86d7:fa62 with SMTP id
 2adb3069b0e04-53877538cc6mr1823486e87.23.1727269013251; Wed, 25 Sep 2024
 05:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-7-ea79102f428c@suse.cz>
 <6fcb1252-7990-4f0d-8027-5e83f0fb9409@roeck-us.net> <07d5a214-a6c2-4444-8122-0a7b1cdd711f@suse.cz>
 <73f9e6d7-f5c0-4cdc-a9c4-dde3e2fb057c@roeck-us.net> <474b0519-b354-4370-84ac-411fd3d6d14b@suse.cz>
 <CAB=+i9SQHqVrfUbuSgsKbD07k37MUsPcU7NMSYgwXhLL+UhF2w@mail.gmail.com> <fcaaf6b9-f284-4983-a8e3-e282dd95fc16@roeck-us.net>
In-Reply-To: <fcaaf6b9-f284-4983-a8e3-e282dd95fc16@roeck-us.net>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Wed, 25 Sep 2024 21:56:40 +0900
Message-ID: <CAB=+i9Ty5kUUR1P_ahSfReJAOfhQc_dOdQ=9LBZJ4-=1kEOVXg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] kunit, slub: add test_kfree_rcu() and test_leak_destroy()
To: Guenter Roeck <linux@roeck-us.net>
Cc: Vlastimil Babka <vbabka@suse.cz>, KUnit Development <kunit-dev@googlegroups.com>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Jakub Kicinski <kuba@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Jann Horn <jannh@google.com>, Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 11:13=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On 9/21/24 23:16, Hyeonggon Yoo wrote:
> > On Sun, Sep 22, 2024 at 6:25=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 9/21/24 23:08, Guenter Roeck wrote:
> >>> On 9/21/24 13:40, Vlastimil Babka wrote:
> >>>> +CC kunit folks
> >>>>
> >>>> On 9/20/24 15:35, Guenter Roeck wrote:
> >>>>> Hi,
> >>>>
> >>>> Hi,
> >>>>
> >>>>> On Wed, Aug 07, 2024 at 12:31:20PM +0200, Vlastimil Babka wrote:
> >>>>>> Add a test that will create cache, allocate one object, kfree_rcu(=
) it
> >>>>>> and attempt to destroy it. As long as the usage of kvfree_rcu_barr=
ier()
> >>>>>> in kmem_cache_destroy() works correctly, there should be no warnin=
gs in
> >>>>>> dmesg and the test should pass.
> >>>>>>
> >>>>>> Additionally add a test_leak_destroy() test that leaks an object o=
n
> >>>>>> purpose and verifies that kmem_cache_destroy() catches it.
> >>>>>>
> >>>>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >>>>>
> >>>>> This test case, when run, triggers a warning traceback.
> >>>>>
> >>>>> kmem_cache_destroy TestSlub_kfree_rcu: Slab cache still has objects=
 when called from test_leak_destroy+0x70/0x11c
> >>>>> WARNING: CPU: 0 PID: 715 at mm/slab_common.c:511 kmem_cache_destroy=
+0x1dc/0x1e4
> >>>>
> >>>> Yes that should be suppressed like the other slub_kunit tests do. I =
have
> >>>> assumed it's not that urgent because for example the KASAN kunit tes=
ts all
> >>>> produce tons of warnings and thus assumed it's in some way acceptabl=
e for
> >>>> kunit tests to do.
> >>>>
> >>>
> >>> I have all tests which generate warning backtraces disabled. Trying t=
o identify
> >>> which warnings are noise and which warnings are on purpose doesn't sc=
ale,
> >>> so it is all or nothing for me. I tried earlier to introduce a patch =
series
> >>> which would enable selective backtrace suppression, but that died the=
 death
> >>> of architecture maintainers not caring and people demanding it to be =
perfect
> >>> (meaning it only addressed WARNING: backtraces and not BUG: backtrace=
s,
> >>> and apparently that wasn't good enough).
> >>
> >> Ah, didn't know, too bad.
> >>
> >>> If the backtrace is intentional (and I think you are saying that it i=
s),
> >>> I'll simply disable the test. That may be a bit counter-productive, b=
ut
> >>> there is really no alternative for me.
> >>
> >> It's intentional in the sense that the test intentionally triggers a
> >> condition that normally produces a warning. Many if the slub kunit tes=
t do
> >> that, but are able to suppress printing the warning when it happens in=
 the
> >> kunit context. I forgot to do that for the new test initially as the w=
arning
> >> there happens from a different path that those that already have the k=
unit
> >> suppression, but we'll implement that suppression there too ASAP.
> >
> > We might also need to address the concern of the commit
> > 7302e91f39a ("mm/slab_common: use WARN() if cache still has objects on
> > destroy"),
> > the concern that some users prefer WARN() over pr_err() to catch
> > errors on testing systems
> > which relies on WARN() format, and to respect panic_on_warn.
> >
> > So we might need to call WARN() instead of pr_err() if there are errors=
 in
> > slub error handling code in general, except when running kunit tests?
> >
>
> If people _want_ to see WARNING backtraces generated on purpose, so be it=
.
> For me it means that _real_ WARNING backtraces disappear in the noise.
> Manually maintaining a list of expected warning backtraces is too mainten=
ance
> expensive for me, so I simply disable all kunit tests which generate
> backtraces on purpose. That is just me, though. Other testbeds may have
> more resources available and may be perfectly happy with the associated
> maintenance cost.
>
> In this specific case, I now have disabled slub kunit tests, and, as
> mentioned before, from my perspective there is no need to change the
> code just to accommodate my needs. I'll do the same with all other new
> unit tests which generate backtraces in the future, without bothering
> anyone.
>
> Sorry for the noise.

I don't think this was a noise :) IMO some people want to see WARNING
during testing to catch errors,
but not for the slub_kunit test case. I think a proper approach here
would be suppressing
warnings while running slub_kunit test cases, but print WARNING when
it is not running slub_kunit test cases.

That would require some work changing the slub error reporting logic
to print WARNING on certain errors.
Any opinions, Vlastimil?

Thanks,
Hyeonggon
