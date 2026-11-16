Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794858626;
	b=BJv41PENDL6NrpTKZUANaI1wnNoYAMAQOiwDRenx8GN907NFqgjGa9natGRKzHPVvstp
	 AIOfdsFcXP4ws5fZOtbHAiOydZ02OMom8C5DEu6nMx/2j2rI/vUv5pep66/yWZCgtSVC6
	 XX5Bc8WN4IA1Ds9QItiVId30XwlrOFO3tiBG+4hGFHu5TjCulgR15I+UO+HnSWVT03wsX
	 929Fs8rL7YCZzY9oxV0rAbe/Mqo2dCBuZr3FYiKf7086kXLdRsMRmPCwsXjbZbIIEreSQ
	 uxoArF2HZh4SBilo4EiNrZ9X2wWRsNpf6MtHPrmcPmBVD3g30Nm4RwE+aYd+NlWoutA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DZQ8g8pBKXPUn7Qnj5OUU6UZ0jQwjkWgH4vQN0jAVko=;
	b=ADTvkFoXgfEkFchbUsvUcqCqnFPi1cJu2Rl0sJ1iNZsojHMNsjo2JCqEknCrxS6Qt53A
	 HkHC01C9xAwPmraRLIQxfZfDgoLMMwOZkldhC+0LT5kHBd+lu2aaq2Ppv6NjN+R/WwNEJ
	 YIUqFpfA1BAmlCnTkdB8SFD+svv25N6p6s842LDfqT9Y16Kwxx3CvNpoI0ZtsYMySUPzp
	 /nNAcaQZw2gPjEsW6oNK0YmOTK7Lv8t/TRWveXXJ4Dd0YzFFU7IDpy/8FdQaeDKGCFlSj
	 X7UsmerIYHZSMl3bsBkfMs4mnCRtlt6LHXsuCQIWw+ksytcgrocDcKsOSjpvxElebEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=joelfernandes.org;
	spf=pass smtp.mailfrom=joelfernandes.org;
	dkim=pass header.d=joelfernandes.org header.i=@joelfernandes.org header.a=rsa-sha256 header.s=google header.b=t9heb1Gl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F0B606A322
	for <rcu@vger.kernel.org>; Mon, 16 Nov 2026 19:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0F0B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.a=rsa-sha256 header.s=google header.b=t9heb1Gl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so24218105e9.3
        for <rcu@vger.kernel.org>; Mon, 16 Nov 2026 11:50:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794858624; cv=none;
        d=google.com; s=arc-20260327;
        b=Y0U5VamihwViBoBH9XmfpRKOQme88Pw3yP3HWQBIpUmVfiZ1bKcmPzeSL2zA+DUfmV
         +hLSygPa8SX9RopAzVk56gH0QviNMTTeCi+2M/6Ya045JBmdY1+4Ty1dm7YPDpZGi5OL
         SpDqHv5AtUyD5WxDW4eQYCxp1hiDjMfmADv/R/8P+GlPHVscQGTwr90bZacAIp8xqKVT
         suOCYkbCaNXbl+p9n3nldMlpQYHul8uaBc2ycwd5bH9+Ara5rKq5djFLwpa0YAgUYj7u
         anhuik1HEONYGBOFy0KWKxCnl2MYBODZADvCx0493OUFTl10unk7F2kVlxyY0i7HHlFA
         LC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DZQ8g8pBKXPUn7Qnj5OUU6UZ0jQwjkWgH4vQN0jAVko=;
        fh=dIwWq8WEUuRYQ/qIyR2CFkpw4sAzuEhXuVar2PyK4Qg=;
        b=dCIhB/6E2+pHnq9drIxuXG9ASXPZcX4wN9zhXsBJRX54n6KA964ir/iG+6fIYcqPF2
         aK2KWEqP9hjEspeq2iRbicPCLk//pmcgYXh4YIaXk/ML7Aoq3RWsCcpuv1g3fTuXqU3l
         CzssRuHXXFvS7XlbP9seEZPn3sqdfs4uKXLAEa1YEB+MyLoxLk7/3RNst642Ie1EkYnr
         SwVAvKFb2Abs0JrDvOJYR6ruhYt0zW+KOWeW6ozlI7+A7XGJwsPrpH9FKrp/j6MGG4BK
         xAyCf9QHu4zKN7/KX1diaicsvwKC+zLl5O7GlXhR84Rf4AhzW5Us8FcjpmqHJpeb9ebM
         CuuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1794858624; x=1795463424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DZQ8g8pBKXPUn7Qnj5OUU6UZ0jQwjkWgH4vQN0jAVko=;
        b=t9heb1Gl5CT4fOX1siaxtEGwi+nOTA/37tqWgMEuOzRFP8Su0zdNlZ7xT9+VVwuay5
         NbNIc630GgrBXv16jsoR0Qw6ufkgo9iqj2CawrwvQkY8Ews9brpgfeZM+VsA8u5DobT6
         dss8uzJ2coTEtQCrDZl+InEhO8vHQlW0nhoHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858624; x=1795463424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZQ8g8pBKXPUn7Qnj5OUU6UZ0jQwjkWgH4vQN0jAVko=;
        b=s6rIlKCHZEYNulpcIXMJhMfZtlHMpBcBKJ11ssYaEI/rcyeu/IXtKRiNYdqRpJQpkI
         7XIGNhx1mijm6/YmZxsvzQL5A5YnvVnw/0rLtwYB25JtrtyXTjXSRN3xY27x3b1rBMZ2
         xTtmWwOynttQg9nNifENO7MUIWK0oeJ7W4O2cBcWIwHu/+T/w26o1weMEFgnBXZDv4CP
         ALtpTvKOvgMs1l+1xOVkiBtdbZNabTPqutHdnZb4cDxZPuLEm2qpH8qpXE4FJ0tSO3zF
         t1Thf7UjHMWIq/cjZwevM1LM5ySaLB0M495A8tauF5krgg70gVGNC5prSuxhYfYleyVI
         B7fA==
X-Forwarded-Encrypted: i=1; AL+hErEJLiGYXbSF2Dqhn06FS5FOh8FcX8Q1yNNAJNwEf3u5EmH2heDXuQGn8ERwZGtB70R1yqM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rz0IB29fty/UiSS4ZEvEMlcJA1jl5WzLCMop93i9claAcaWIX
	0mmIRJ7jQ0IP0SxeizK/XvOut5AhDscvEkIVIAdt3HpV5dcWoEeJ4AnfFXbeJUYCzl5bJgKTiZS
	6SMGD482lzG3MbIQEsj/67pVZcVJh1LY4FoSozA/M5AryVQfUXn6L
X-Gm-Gg: AYBFou0viCLJC1MPFAHw86NrsUU9oSIaRmxvTGEQmyg1bFmo81Dy29b16oK1XPxEWaU
	dkhdjNrhTc+Zm0yAOaWcaGIxGepRpRVFcQlvoHvkvIBp04vD4u1VEKnhOe/ahLAr6crCoWt1jn5
	IaFzIZIrBdsyw6FWn4jjPmGhiZKyDo8VkVzdwf0Sts4z1VCUATbJ35zgi/at6cMhy2Ez1KvI/oT
	D2+pA10Qgf7crCp8/e+bnT5oCw7EZ+9Gc7J64HemIWTUZNYyw2ffk6RRa2yqfW3Yrs92NoRNgyy
	Tl8rTHRNLtP2wgUhh9pTHmNkNbNtRs03piGiNArHMJYpNTj469m64TG4vooWgCHG9b6SLv8MLKD
	Sg/d2r/LgExmTy9vZChs96+KEholR+EISfROLRhuRAcEGlaBLtCpUUMpypkI=
X-Received: by 2002:a05:600c:6085:b0:4a2:967:dfb8 with SMTP id
 5b1f17b1804b1-4bb55a8d7abmr242122285e9.20.1794858623724; Mon, 16 Nov 2026
 11:50:23 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <bf761cab-7423-464b-ba8e-bd39ad0eb089@paulmck-laptop>
 <20261116190040.GA946893@joelbox> <e173f3b7-de3b-4b3d-b0dc-c12a091c9723@paulmck-laptop>
In-Reply-To: <e173f3b7-de3b-4b3d-b0dc-c12a091c9723@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Mon, 16 Nov 2026 14:50:10 -0500
X-Gm-Features: Aa3M54pUdJtYoXfs6_hi-uMPCuD52vPT7nhCDuNa_U_gOkj5n8f96Yty_s2ceZs
Message-ID: <CAEXW_YScx57GaYLgUYXVGFm6vq-_eayhJCv4SCKTqhOaspJEmw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Additional miscellaneous RCU updates for v7.5
To: paulmck@kernel.org
Cc: Joel Fernandes <jfern@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 2:48=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Mon, Nov 16, 2026 at 02:00:40PM -0500, Joel Fernandes wrote:
> > On 11/16, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > Hello!
> > >
> > > This series provides additional miscellaneous updates for v7.5:
> > >
> > > 1.  MAINTAINERS: Add Puranjay Mohan and RCU reviewer.
> > >
> > > 2.  Make torture.sh test NMIs for atomic SRCU on x86.
> > >
> > > 3.  Avoid duplicate identify_qemu_vcpus calls in torture.sh.
> > >
> > > 4.  Make torture.sh test NMIs for RCU on x86.
> > >
> > > 5.  Make kvm.sh ignore empty-string arguments.
> > >
> > > 6.  Use ${:+} to save a few lines in torture.sh's torture_one().
> >
> > Thanks, I will apply all except 2. and 4. as they depend on Mathieu's s=
eries
> > which is not going in for 7.4:
> > https://lore.kernel.org/all/20261112133731.127221-1-mathieu.desnoyers@e=
fficios.com/
> >
> > For the others, I have replaced patches which were already there (in 7.=
4 next
> > tree) with the new ones you sent, with updated tags.
>
> Thank you, and apologies for missing that dependency.  Distractions this
> morning.  ;-)

No problem, though you might have been secretly testing if I was awake. :-D

thanks,

Joel Fernandes
