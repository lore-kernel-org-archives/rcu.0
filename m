Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D24A11712;
	Sun, 22 Sep 2024 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726985826; cv=none; b=tRacZ8UgAPrPsT4l0Jc3bdg2QMQJgYFSE/FFVmnfVpLcWr0uA3CFT4M891Op1aK0AqwPTHH0aUnvbtgm46ivQbP5QGwg5y8h/ajOFqKFGXMXNtN/zaQx8H1fXmMHIXo1sgKVxKXCrAOBBlR+8fCDHMLjoVJ8leVsEeVGWSX/mY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726985826; c=relaxed/simple;
	bh=Dn2ictoSHLp+l35mgClPZL8BskA+nsyYSb4MVFpd50Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnUtuatnWNgQQAmOjfllv1BdsG9OCw9qnpT45LmluD3ex+xUVHfZwUI9oRfZSI84eOGtTJmClrveFx4mCO318xbaGFX1LwW5enk6g/QL9x+Zk66Yq597XJsFCsfG1AIXdskRcDY6hWQdc1E0gJV77hxM94FmnUu4veGozibkPIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPY20O26; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPY20O26"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53659867cbdso4675708e87.3;
        Sat, 21 Sep 2024 23:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726985823; x=1727590623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dn2ictoSHLp+l35mgClPZL8BskA+nsyYSb4MVFpd50Y=;
        b=NPY20O26Dq2/eI6WKMzi+3vqIJ/6b1mcOcVjrf10Wrm0Jrw53XkbXUXVsfi0zQvv6y
         7BdKaKIgpsKKHwLq/fy04WxuwtMbdkBhatZ2OQ6B6K1zzuPBsCBPxHbRhmvzUaXVPyLu
         aoniPjXl9fWAKcQUh8BJewYMN+Sqf+SzfdNreU3wB/Lz4Lb7Ubecj4Ta4gaMdbOvNalq
         DAUILnJAS/ouVoy5YHy8+T0vbgYrPgso9ChsBxeT6dzYj9tChiMpDRj54FvZFJrewCvU
         WNqHqj+/fDNccrBrgqSmiCwDFRPmqqFrLRQ8ppKszocyJyiGqYnSXqVzlMFevX7pxFgs
         BMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726985823; x=1727590623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dn2ictoSHLp+l35mgClPZL8BskA+nsyYSb4MVFpd50Y=;
        b=sK0TOp1fyHeZl2IC0Qlhll2LvFq0kf5VFrJZqi7iVSJw1UWVUHLbNEbyfjr+ZUK7iU
         77RDoFOcI7+JarUlQ2sHgBDnsLcNc6OpPjs88ZQOTGD1V0TvFnuj+ROoHY048Ul1jqSA
         Sxq4anilMxu4L9zKc88x1kKQz3zxsTsszTJpwGY1lRxltEMY4OMOSbWUmUCDrKfyqj/q
         9xtNDGtpozzfuAd9vy1omFBy4I8RCFh/5JPobVytyoBU0NvbFyYFiaKzVN89g9Uoo2FC
         ZHcSrk1CV99Ypf31CMDFTht7jyjUnCBEnWFepxa5d8h9LMp0hPI8V+TriFGIsTcgKNH2
         eK8w==
X-Forwarded-Encrypted: i=1; AJvYcCXBSmAonaIClu1r+mFVwxfq8KA+/kBS+6u5EgkdFOkxXsoUUuIkOfS2VVwaC2rjd44dDR6g@vger.kernel.org, AJvYcCXUvYRdidsewcbAu4dVQpw6irRJmibHQN7qH7idHIfPgCNjewErJ+1K7oNDO+X3utwxMki2mASNe2iWJnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoBxgaVxdBDki+96nC4yH2zbMTrcSlI+hzVBOpCUdeuCTxmbH8
	Fhuk/O6xVPIOF9mQG65a1St4ZmyBy7a1M45eK9Ptp4aCkyPaNEWJhcgQXS+6lWTia2I/LPWyhWu
	fMvKZb4hCZyFaZWPskwtYnm0iNIo=
X-Google-Smtp-Source: AGHT+IF4dGVz7RZXvuU7SyII+eRSMktamN/N3uSQWpidMLchgA4iceWv6VyclTJtuGP+eZ/1xhxc3P2N1rufYmv/8KE=
X-Received: by 2002:a05:6512:6d1:b0:52c:d628:c77c with SMTP id
 2adb3069b0e04-536ac32f044mr5163363e87.43.1726985822724; Sat, 21 Sep 2024
 23:17:02 -0700 (PDT)
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
In-Reply-To: <474b0519-b354-4370-84ac-411fd3d6d14b@suse.cz>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Sun, 22 Sep 2024 15:16:50 +0900
Message-ID: <CAB=+i9SQHqVrfUbuSgsKbD07k37MUsPcU7NMSYgwXhLL+UhF2w@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] kunit, slub: add test_kfree_rcu() and test_leak_destroy()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Guenter Roeck <linux@roeck-us.net>, KUnit Development <kunit-dev@googlegroups.com>, 
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

On Sun, Sep 22, 2024 at 6:25=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/21/24 23:08, Guenter Roeck wrote:
> > On 9/21/24 13:40, Vlastimil Babka wrote:
> >> +CC kunit folks
> >>
> >> On 9/20/24 15:35, Guenter Roeck wrote:
> >>> Hi,
> >>
> >> Hi,
> >>
> >>> On Wed, Aug 07, 2024 at 12:31:20PM +0200, Vlastimil Babka wrote:
> >>>> Add a test that will create cache, allocate one object, kfree_rcu() =
it
> >>>> and attempt to destroy it. As long as the usage of kvfree_rcu_barrie=
r()
> >>>> in kmem_cache_destroy() works correctly, there should be no warnings=
 in
> >>>> dmesg and the test should pass.
> >>>>
> >>>> Additionally add a test_leak_destroy() test that leaks an object on
> >>>> purpose and verifies that kmem_cache_destroy() catches it.
> >>>>
> >>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >>>
> >>> This test case, when run, triggers a warning traceback.
> >>>
> >>> kmem_cache_destroy TestSlub_kfree_rcu: Slab cache still has objects w=
hen called from test_leak_destroy+0x70/0x11c
> >>> WARNING: CPU: 0 PID: 715 at mm/slab_common.c:511 kmem_cache_destroy+0=
x1dc/0x1e4
> >>
> >> Yes that should be suppressed like the other slub_kunit tests do. I ha=
ve
> >> assumed it's not that urgent because for example the KASAN kunit tests=
 all
> >> produce tons of warnings and thus assumed it's in some way acceptable =
for
> >> kunit tests to do.
> >>
> >
> > I have all tests which generate warning backtraces disabled. Trying to =
identify
> > which warnings are noise and which warnings are on purpose doesn't scal=
e,
> > so it is all or nothing for me. I tried earlier to introduce a patch se=
ries
> > which would enable selective backtrace suppression, but that died the d=
eath
> > of architecture maintainers not caring and people demanding it to be pe=
rfect
> > (meaning it only addressed WARNING: backtraces and not BUG: backtraces,
> > and apparently that wasn't good enough).
>
> Ah, didn't know, too bad.
>
> > If the backtrace is intentional (and I think you are saying that it is)=
,
> > I'll simply disable the test. That may be a bit counter-productive, but
> > there is really no alternative for me.
>
> It's intentional in the sense that the test intentionally triggers a
> condition that normally produces a warning. Many if the slub kunit test d=
o
> that, but are able to suppress printing the warning when it happens in th=
e
> kunit context. I forgot to do that for the new test initially as the warn=
ing
> there happens from a different path that those that already have the kuni=
t
> suppression, but we'll implement that suppression there too ASAP.

We might also need to address the concern of the commit
7302e91f39a ("mm/slab_common: use WARN() if cache still has objects on
destroy"),
the concern that some users prefer WARN() over pr_err() to catch
errors on testing systems
which relies on WARN() format, and to respect panic_on_warn.

So we might need to call WARN() instead of pr_err() if there are errors in
slub error handling code in general, except when running kunit tests?

Thanks,
Hyeonggon
