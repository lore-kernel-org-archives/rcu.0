Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794499285;
	b=cXNIaWjK0gmSFa+L57MgIF/hx06aIvnvdOsOrSGyDlgx5UPC58tpFG6j/xjv7KhLQb4x
	 m9HlYiL9jp94U/KYROb4KQYsQEEoUEfqgeI99n+pzUh8EOlqpZ1BmNPwJYNU2uNMeXdUD
	 CotDVkbq4fHwHpQ1Tgbfux4OdOMhNFOmPnRYVu4keCssid/QaaQVL+k/47EPJ2E3AayXc
	 oQG2tRoCQuePJARATTgpGXKfZZQohv37OB6R7aL1E/1sFyVoKQYX+eC1NiV0JrtA+62ay
	 lCY9EOBOL+mIiIlYJEJOQn8hPSh92Vu6A+LEa8WtIDuZpBFp8HnsHb7GW0+7/njhJ7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=K30WU9LcDm9KOHnUzmPG5F9Q3grxCVKpIQuAPTV3Oio=;
	b=bP9SJ8HJ0vWOAqKYa/5CyFj7JU6Ej+QllojR1aeunCMIKb4/qbDZXNfYAwm7xCWWEyjq
	 qKmaeqPQuWt7c1GHkpagKYfDHludsqbbPyTD269cnOQ9GlCmPU2zOYOmHUhgMHOKKRULX
	 Czcn1mTu6Ji16C7SIZU9S/mpEZb5JdxrEx2pUNyTjURRb43rKLY2aIsXqJe77P1Mq5GA4
	 C3Tp8SowvpRWw3+cyA/x9XM64vW1z5LtlCDa9j4jiTRFXPvhMqoX8rLK9IiRVELN0bhnI
	 wPVPs+NqB70XMfZlpVtNwV9C3M6eVk8pLpdnlDybYXojv4pKVJgFdmfC6xxVjhfhJFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=asQ6Kkgb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36449606A31C
	for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 16:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36449606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=asQ6Kkgb
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so55530805e9.0
        for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 08:01:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794499282; cv=none;
        d=google.com; s=arc-20260327;
        b=bzobeAgMeoGHqWcvbvI3rI+aa/2U/k5bkrpcF1vT13XjyT8AIq+nzlK6XowqrXrqCX
         LacovrLNkUBPbZXys3dHTi3zZ/TWZO02wooa7W800yfX0gPIZCgeUO1W/afqkespEPUj
         weQXCcgkm2nBRgBO2AATZ+m9yCAvOXOlUrbD4xa9qUuQGaOTIBkkrZRtTceePDJSfiYg
         ALWdCpzuvNCixQsojC0TtlH18JLTQ2y6UDmUynOqAJq7BmVyS1LalyWOEmWfT6V5hKhh
         C7CnkvD2rtL+sF5BhgGTdro/3RcPXgvFFFymfWxSecmJvHboY9n66qmMA36lVGwdGyX2
         q3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K30WU9LcDm9KOHnUzmPG5F9Q3grxCVKpIQuAPTV3Oio=;
        fh=L/ziqf0SpdnTENOKV9WvRSdb0LBTxkDtewwB7nQR4z0=;
        b=ax9K8VH6ffmGeK++IcFoF+Sg7m6xu4ea9Ogxi8oadsoADkAKXriJPWDxumO7GIMT5N
         rs2PQl7cAat7LC6W0sx4suc3n/Hh2av/mf5UYtPWNBkvrRN6fvHMucDdkzEBi3XkPCe+
         HO/2P5RGoGQNgS5svk+GfjA+xwnXOwaOgzyiwMXhE5SjKg6REMcJ4W5XW0IcYYuCAqsQ
         IxEdwh0pfmgTD9rn0sVqyOr6ygybEr7vZLBeTYFqBLVAAxdFqRPMYn81pRn+fQq7O5vx
         OzDEkw0FYhlFQOUH75a9c/8+eZhcoKV3e5HsLiMm8gFcQP0euu14Nk1tpwDJ8MSl/ZZr
         fJWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794499282; x=1795104082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K30WU9LcDm9KOHnUzmPG5F9Q3grxCVKpIQuAPTV3Oio=;
        b=asQ6KkgboxQr2Mix4uFXV97OZ4yQDaOEh9XXJvisPx2EPGhn5J8mcUoEZGV1Qeagb0
         Ai7PxqX8tEH8mdpe/wwT65dwo+YA6B9kehSmgtkDDpS13Hr62CAOHX7C5QdKM+IGnSfI
         QkCMfS34Um5jNw5/L/5hM0f9cN8RySssd5TviZczWCdI7osE4Z8oZQAb9qD794opBVCq
         gpAzdC2ceN0QkqGe+vB6SzZyXV84S/smCWXulY4TtzR5YGtNMSBL48Is2CzXKFW2QfGf
         6O0jxlFZn87zP3M5OnX6S5Pxeu/cFTk/Et89FxtMSHEkDVN1+uecNnARomY1gctIsF1O
         qqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499282; x=1795104082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K30WU9LcDm9KOHnUzmPG5F9Q3grxCVKpIQuAPTV3Oio=;
        b=DHu7WX+b8Q6Dsmagor5hvMqwTtR6Yd16EsxjI7c4yByjz36YB9J5RgbImtMZacXWiQ
         +zS2JiajGUlmpGzXYAPmH8Euyph6mPq84UqsblOQgHkBhVNki/DlUgYSvMBe+gM7MO4L
         oYlmwM36tlkAYzcmVIvluG11zxTIGs6yKvdyY0POPbaOumARlNUMXGkxfEd01UHLRUyc
         DMS/jOzIcxVkfai0WdZhDSkiD1DcuYDAmVaU1l2zz32dezy6Z19X6xuElcVYOtA96ChN
         aYi+vMxZkkq+twsswaEk+dB95Dsfua0U9oFvAvMkHuOxMU6VeycRcTZP3B0Kh4WhBS3M
         q/cQ==
X-Forwarded-Encrypted: i=1; AL+hErHLH72vfsorEIprvP6GZqtw0ma79GLEG9EDZLRQpwoOZN8Y8Y4Kq5MK9iaeq4xRLMaK0Mc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pX1WxlTz/huLmRrv+0y4kCdgC0NVvM6lqct43uTfwwHnY9zpv
	aN3mw/3m4SRhsptfBWc76iV9wq8etKsOfH6TUgtpjNF2fCjualJBgITUo/Hh+CrI9G66Wf90xpU
	NMlErWkpNhs1dF5iysgEIo3N8vUx14SY=
X-Gm-Gg: AYBFou2nCu0Ln63uGVSNMntDZy2arDv6H56hrSdinsjw9MnXUeMdJTTR/fwJaHEexiM
	bF8PDNJDttz0/00LBHU/GatFv5ZVLy/chHGnYrtZTOxAe6ZxmIuyh53bisLhbXPVZzq6QhoZQ0/
	ZEU7e9tTTIWTYJiU3dqqgjXLfOxBXZ/BPU2UE4yZ3Hiy5e2vDFJSBtGggdmleTefRcjbG6emUGI
	jAEgkO2tfGJ/hl6IL+nshqYbeZvtOrN7DolvYeJxcuv0EhHMZqsU1EGjxQKmW1IPH9ntJb1dW2y
	kWHeZ9JUc/RzuUAHXbKxwfv7w7y59WiMMlq5L9gjarNTkfICV8kBW8UQkIWL9BytbzBA/MtF0br
	n9rWc6UIDNU/8kVFPdM0m1JKikXfOMH54WOswUKHYQGU/MrZCYwgZMnXr+AnBuE4oUyk20g==
X-Received: by 2002:a05:600c:1d29:b0:4a6:42cc:bf65 with SMTP id
 5b1f17b1804b1-4ba0938182bmr115084735e9.17.1794499282029; Thu, 12 Nov 2026
 08:01:22 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
 <20261104165504.2430480-10-kunwu.chan@gmail.com> <381033ae-d65e-44de-bbe7-69f707405f40@paulmck-laptop>
In-Reply-To: <381033ae-d65e-44de-bbe7-69f707405f40@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 13 Nov 2026 00:01:10 +0800
X-Gm-Features: AclHuK_r0z0qzRgTWpnMwVZyYzYAfYE6f8hG1Sg9QutknQhxmorMBRwJwam3dq4
Message-ID: <CAN_Opa9F9prFRqta5KwCHoQHrmsOEB4_m2tst0+0VY+fh5o2cg@mail.gmail.com>
Subject: Re: [PATCH 09/28] hazptrtorture: Add READERS4 and READERS0 torture configs
To: paulmck@kernel.org
Cc: boqun@kernel.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	corbet@lwn.net, mingo@redhat.com, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, josh@joshtriplett.org, urezki@gmail.com, 
	dave@stgolabs.net, stern@rowland.harvard.edu, parri.andrea@gmail.com, 
	will@kernel.org, dhowells@redhat.com, j.alglave@ucl.ac.uk, 
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, 
	joelagnelf@nvidia.com, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	longman@redhat.com, rostedt@goodmis.org, qiang.zhang@linux.dev, 
	brads@mainlining.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev, linux-doc@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 5:37=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Nov 05, 2026 at 12:54:27AM +0800, Kunwu Chan wrote:
> > Add READERS4 and READERS0 configs to cover reader-active and
> > reader-free synchronize paths.
> >
> > Both use the PREEMPT baseline and hazptr-stack torture type,
> > with four readers for READERS4 and no readers for READERS0.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>
> For these, why not just add '--bootargs "hazptrtorture.nreaders=3D0"'
> to the kvm.sh command line, for example in torture.sh?  Ditto for the
> four-readers case.
>
Hi Paul,

Agreed. I wanted to keep the zero- and four-reader cases as
explicit, repeatable tests. I'll drop the separate configs and
retain them as scripted PREEMPT runs, passing nreaders=3D0 or 4
and torture_type=3Dhazptr-stack through --bootargs.

Thanks,
Kunwu

>                                                         Thanx, Paul
>
> > Acked-by: Bradley Morgan <brads@mainlining.org>
> > ---
> >  .../selftests/rcutorture/configs/hazptr/READERS0 | 16 ++++++++++++++++
> >  .../rcutorture/configs/hazptr/READERS0.boot      |  2 ++
> >  .../selftests/rcutorture/configs/hazptr/READERS4 | 16 ++++++++++++++++
> >  .../rcutorture/configs/hazptr/READERS4.boot      |  2 ++
> >  4 files changed, 36 insertions(+)
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/R=
EADERS0
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/R=
EADERS0.boot
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/R=
EADERS4
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/R=
EADERS4.boot
> >
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS0=
 b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0
> > new file mode 100644
> > index 000000000000..c5b12f3bef74
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0
> > @@ -0,0 +1,16 @@
> > +CONFIG_SMP=3Dy
> > +CONFIG_NR_CPUS=3D16
> > +CONFIG_PREEMPT_NONE=3Dn
> > +CONFIG_PREEMPT_VOLUNTARY=3Dn
> > +CONFIG_PREEMPT=3Dy
> > +CONFIG_HZ_PERIODIC=3Dn
> > +CONFIG_NO_HZ_IDLE=3Dy
> > +CONFIG_NO_HZ_FULL=3Dn
> > +CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_SUSPEND=3Dn
> > +CONFIG_HIBERNATION=3Dn
> > +CONFIG_DEBUG_LOCK_ALLOC=3Dn
> > +CONFIG_PROVE_LOCKING=3Dn
> > +CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn
> > +CONFIG_DEBUG_KERNEL=3Dy
> > +CONFIG_HAZPTR_DEBUG=3Dy
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS0=
.boot b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
> > new file mode 100644
> > index 000000000000..f5564c218902
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
> > @@ -0,0 +1,2 @@
> > +hazptrtorture.nreaders=3D0
> > +hazptrtorture.torture_type=3Dhazptr-stack
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS4=
 b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4
> > new file mode 100644
> > index 000000000000..c5b12f3bef74
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4
> > @@ -0,0 +1,16 @@
> > +CONFIG_SMP=3Dy
> > +CONFIG_NR_CPUS=3D16
> > +CONFIG_PREEMPT_NONE=3Dn
> > +CONFIG_PREEMPT_VOLUNTARY=3Dn
> > +CONFIG_PREEMPT=3Dy
> > +CONFIG_HZ_PERIODIC=3Dn
> > +CONFIG_NO_HZ_IDLE=3Dy
> > +CONFIG_NO_HZ_FULL=3Dn
> > +CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_SUSPEND=3Dn
> > +CONFIG_HIBERNATION=3Dn
> > +CONFIG_DEBUG_LOCK_ALLOC=3Dn
> > +CONFIG_PROVE_LOCKING=3Dn
> > +CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn
> > +CONFIG_DEBUG_KERNEL=3Dy
> > +CONFIG_HAZPTR_DEBUG=3Dy
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS4=
.boot b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
> > new file mode 100644
> > index 000000000000..0d0df3f7dca4
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
> > @@ -0,0 +1,2 @@
> > +hazptrtorture.nreaders=3D4
> > +hazptrtorture.torture_type=3Dhazptr-stack
> > --
> > 2.43.0
> >
