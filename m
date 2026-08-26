Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2C53D9547
	for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787744238; cv=none; b=HEpGdUy7VlFLFJBe9MfmneAYsZ4lgQ7/lZUU1Jqei3V2Nw+3TJboAYu5BUxgPF6mlhKNzDWu9UTADAPooz+EvEdt/b41+M9hqgIfRaOiiwr0y0I9Rz+vMDfYqOCHZZpd00aX2sijl21PokEQQrELZk8aRTGP34yWvaqN1pbdgXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787744238; c=relaxed/simple;
	bh=hBELgs6oLnJv6ZedX2AgStFlAi3b94Q9z+VxuI2xPeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9P9i3C19FEysGBvIGDCRekCPWQT2sN/7HQ12+fdLBawGElSaLsNN1BtMAnC9zAGaq7+iCr3pXF96aZYpvq2eY7b9Luc8iGgm4y5rqQ4HTVBU7sXZuiqN7Vw/O0HT/gRnLOaBC9QXde2SDdppY1+OoKK83sCSHcyp8Ef1reUk2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nqSJAnRT; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nqSJAnRT"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-97ca72f2cd9so472690241.2
        for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 04:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787744236; x=1788349036; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pt0ASMSpg+qP5hSMqnRIF71XeawcwG7hVoAWpM6hV7c=;
        b=nqSJAnRTlR+cXf5RRXIdgwMZzN2xCLCA16n7ncrwzrpBGBS1v0agNdzgi5qLoM8wYv
         fHTbl3Hsl3djwLF9MDWADxZFupQIPbEcEMS248p4yKgRwcgb8rK3+FUiCL7rMkes7mT+
         7/Ol2Lk6CYaK6RyzYREb6U7n6KtTQxybofMwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787744236; x=1788349036;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pt0ASMSpg+qP5hSMqnRIF71XeawcwG7hVoAWpM6hV7c=;
        b=Ovr+C62qjtwN0XZhBL+pUgKSdhO2JceJhzVKLNNfrv1YOXqL6noqP2uTOsMJtkpzhx
         ZUGLcVKzyDdi0+Epo+tYZAoUyjr18oChnPsGS0NoFfYWk0UZaZzM30LF247Vf4xbMjGT
         fw6R6eBf0E8TOw8ypjdmlHOQWZvcCz72lnBvP/VMsv1d1MQ7DFIiVuXe7HX+/RVsL2bS
         C4qRQ4fBY8c0NtanElekRNl48qt0/AzjHV/fH4Uxekp+PrFfdCNGkDCvyZhWZwCvW4Fc
         0JThbuzWEGR19/EB7/KRnw339UTtUE8UPzRNJ3+MEQI3PflKUFUNUF20VGhVmfjyXFts
         Mn+Q==
X-Forwarded-Encrypted: i=1; AHgh+RrgwBBElHFhmV9zP+UXVUoM7bOXtecZCCGW+7EL7IggWl9OO4iDjV/PkaFgzQ0dZBd6UB4=@vger.kernel.org
X-Gm-Message-State: AFuF++mry0XNmeHfGk4UpxYkedB8hLdaMiaU7DOmCi99CBdmo9YFl/ti
	fi6ZJoW1jvp0hJs7xUQXsUeIiyXIRjquhiBKPj4uLuCSgV1yboDVuX6XjfMRRIRg5GcU0Shl5QM
	+sPOsKZNm
X-Gm-Gg: AR+sD13e9E6H7tCAy+FrTKjsUMp60QYY4EoF0732RKD7VNEceVt8z/CGRPbCHRd2pVO
	pPQW8NjtHm08Vj7XDoHdWpn5Rx22vwcUca/CFlCXcqhA5G3wc7SN1YQEC0bWa1bylzZ19nAXaJf
	9l3MsewPMk845zGcx5OI0zzqIwFy1dFqbx7vyyxQeEwjMWkExoW+6GuMzoT3U8Lyy8rmKCf6JkQ
	esTvhmsaLb4/AuHce+HRmFTB5W1w9ZYWOn/y53X5cOfeDrO8B7W5UkaUDy65k+TALOT/jkuOJzr
	uMhG5hFghJIYrP9jTFlU+B6yTG3n8eyLsPuKXoy3uSHMZMtzza9puodS5meB8o2cVNVvoirZVZn
	4B0B7MKkA3PI3hRXDnwv0j5+uVoFDR9uQpN/rzMO7XvYTjpNrvvlal1Jn2ZktTyIv9Hlocszfms
	7rtUZwPeonFB1FEZxCIdGvXt/CQyyq95pH6EqZZSPea6XbCBxSGTjxldW1ErzNcFOq5JoXpLCSg
	HsAO81TyA8IpE59Y2xmlNjygmaST7icZ4g26KNl
X-Received: by 2002:a05:6102:3ecf:b0:77b:b14e:b6c5 with SMTP id ada2fe7eead31-782c19fbed6mr2315589137.9.1787744235936;
        Wed, 26 Aug 2026 04:37:15 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97cbe0ff329sm1469103241.6.2026.08.26.04.37.15
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 04:37:15 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5c2ae02f69eso701730e0c.2
        for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 04:37:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RptEIrSSmEuWNWh/DYxhA3Uxm3Pb9IKloF6CX58r4rXtZJC+fdWCpG2oOQat++nSAJFn+4=@vger.kernel.org
X-Received: by 2002:a17:90b:4c4c:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-3966d43edbamr12169733a91.4.1787743736546; Wed, 26 Aug 2026
 04:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-unqual-v1-0-7024fb81b4f9@chromium.org>
 <20260825-unqual-v1-1-7024fb81b4f9@chromium.org> <20260826105527.7ebbb4b1@pumpkin>
In-Reply-To: <20260826105527.7ebbb4b1@pumpkin>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 26 Aug 2026 13:28:42 +0200
X-Gmail-Original-Message-ID: <CANiDSCtKVT9fnkx=-d2-aOd=uqODERFw-fAm6bg2eX=RXGMaXw@mail.gmail.com>
X-Gm-Features: AcwNN1UB7EM_dUNSy2wAOwSUuHUNku7hqUwMzvFGHVMir2-Vyi6RHy6W32JN7ac
Message-ID: <CANiDSCtKVT9fnkx=-d2-aOd=uqODERFw-fAm6bg2eX=RXGMaXw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rcu: Fix casting while dereferencing rcu pointers
To: David Laight <david.laight.linux@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Dan Carpenter <error27@gmail.com>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi David

On Wed, 26 Aug 2026 at 11:55, David Laight <david.laight.linux@gmail.com> wrote:
>
> On Tue, 25 Aug 2026 20:02:10 +0000
> Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 44c07a66edff..80276cedda80 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -488,7 +488,7 @@ static __always_inline bool lockdep_assert_rcu_helper(bool c, const struct __ctx
> >  context_unsafe(                                                              \
> >       typeof(*p) *local = (typeof(*p) *__force)(p);                   \
> >       rcu_check_sparse(p, __rcu);                                     \
> > -     ((typeof(*p) __force __kernel *)(local))                        \
> > +     ((TYPEOF_UNQUAL(*p) __force __kernel *)(local))                 \
>
> Ugg... TYPEOF_UNQUAL() is absolutely horrid...
> When __CHECKER__ is undefined the whole thing is just (p).

About using __CHECKER__: Are you suggesting using #ifdef __CHECKER__
to use TYPEOF_UNQUAL or the current code?

I am open to doing that, but I would like to hear from Paul if he
favors adding the (also horrid) #ifdef to save some CPU cycles on
older compilers.

>
> I suspect reducing all the definitions would measurably improve
> kernel compile time (even before these changes).

When I checked earlier in the other patch in this patchset, with my
compiler I can hardly see any difference in compilation times [1].
This is probably because GCC15 direclty maps TYPEOF_UNQUAL to the
built-in __typeof_unqual__.


Thanks!


[1] https://lore.kernel.org/all/CANiDSCsMrULsrGQg76x28GRXLg+HSKFWhhA14Zcn8hdm4KyOVw@mail.gmail.com/

>
> David
