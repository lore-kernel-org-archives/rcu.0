Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9725F7A5
	for <rcu@vger.kernel.org>; Sat, 25 Jul 2026 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784981077; cv=pass; b=HidkPGg0XtmHsUoSfXa2OgwePrMndmIobA3tweK+iO+F0YK5AR6/wejdFpZqTQWS3UG0Rjl2gm+wy3OTzGSTgXqnFvLQiM/zaZ83LgycmmSMPIt57u3O/dp8unUcUrMtsCcRcLEkUu53+Lt1lZqPuHgjqlNDt9R/9HC3LpkhpOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784981077; c=relaxed/simple;
	bh=GCRHgUN5OrDS3h6TXUSztQQGkBJEns8zn1TosahCLFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdlidVvkBXg1wPX1ZnwY9DCcXje7mUlSwlR0WIlUr7FcbRdZEHaD/ywnEPa2WEBSPNqMw2bthAMeoEBUnIWSkP7XQsCskJvYa5J+AtNVvTDeOZqZNbrUv8DJwySAGE/rvHslZ6MapSpdYeB2NMlW3829VEdaCKQVnIU/UfptdAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2bKQRDX; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2bKQRDX"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c1c24ec9525so199837766b.1
        for <rcu@vger.kernel.org>; Sat, 25 Jul 2026 05:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784981075; cv=none;
        d=google.com; s=arc-20260327;
        b=Ai/UShjKAUhIU6fREsjDpynAKbFJ3AaxpREced4McRIR8IdPR8a9MCTVWcOXR5daj5
         8I3UFGGjuWPGbMs6rAa+iAPmAtwJDSzR4OTLHMZaah0GSZ2scL57EZVuhmnuqTB4TWXY
         LHJuWfR0awkBsmVI71wiPj1KApForuVws6JqXdwUNu2tVCpCFEUsI4fi7BKyf4iPZNqs
         FzJUIao4Fdc5p7SLuPEuL68vwOegdNdfqBb53lIuptwhpI6zkdG6etGl69BGe9DO96Hq
         hFJXIHVLK8+n/1kH16phH6E4EvB5cSHokU+OsogfGvQUArrBoJ1/nWHqgJfyQq6kof5Q
         cmjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tq198tQF1IsV+MyvQWn4ns+avHzmhK6z4MHxI2nb1Oo=;
        fh=jCXfH7gvhINBTSU+oLB6bFWSEnujCu+DQrjcvcETUeQ=;
        b=EJ3KgbKIAGgTb4lPzr0Yb2Hdn1T1SRUbbl+QoDY/NVUHIIhnImCtxTGY0TaC64/485
         qGEqwDs88YTDn9UIAK+m3oZm7k7m19/h6h1gQ10LKPuyw2Y2coZVKip52Krc5f9B1LfN
         AhTyRiyNYbYP/jSufUCTIAsBALV+vsLRNmbZZYmhTONzFx6BGDPFmwOOyQxvB6R7+xG5
         +MmBfRAu6Ceyry/gx8DJVjwlSSnafdWS1FvXTYaldS5Hv2fakdWvLsN1kVKMxI8vMdZu
         NyS0+ii388L+y+3WZXUvf2TZhN8unBhtUkwMuqTfDgN29ilOcXb+LdQhS/ERJeM9dSS3
         aHxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784981075; x=1785585875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tq198tQF1IsV+MyvQWn4ns+avHzmhK6z4MHxI2nb1Oo=;
        b=W2bKQRDXaiKxUlFM9puuh6benUuuvBUbyJFHV/eRLetklJyoiyz72bNHOsi3lKM229
         WNh5cT09R3d/d1KW8vOZWOGvfWUgGifN+TioFzWe81FkMMmSFISM6c3TGgZqm2CVmAG3
         7zihTVssdSFpRbOyp9Q6FppwVbxe8I7WlVpF21GrvW5QWZkfEk2w/fqVRF4/vPqEE6IX
         xjQKmnjvrY7vCZuop7V4zCLUMyPYqfGwbW3IyYY/jZKWXOJZj0t1lGS3EhKCiwBVEoD1
         1bWLiCrrBkEG01CUGuToi4fO1vZ68i4/CKGLxDQy1xc5yAGEW2chkQ0CMfu/1DGGZhtX
         jJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784981075; x=1785585875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tq198tQF1IsV+MyvQWn4ns+avHzmhK6z4MHxI2nb1Oo=;
        b=AsdwA5k1VMIEhbizKewd5EMeeXEa0hiu/u47wnE1zdqG8Mjo9r6tEjPfFHXATppeP5
         rh2JnvoDF3oKBQ/YHBrcZ0PHSDnsHtjJpYPNRy2jFE50JdOr4WBgC1CVjxPE9tuA/VsQ
         ISRg+SbBIFXdsb//CFTLjTDZGaUdQgUzx6VG5m2pFDwEQ/fPKRqrR4XS6P/F+2lrOXiE
         zuFP4o6jLLAMgwChNoc2mwncG8Lu1+3lt00PDgHpclN11YGvvBjwBdEfCCTyDosq9U8Q
         edOdCG1PhYxBMvmB5IahOWuPMh1/Bzfw7P9hr9Zwy2fHb8jrEGa+DiOTKUqZQ6tXNtht
         GE7Q==
X-Gm-Message-State: AOJu0YwrKEn9XMtigRWzRnJhvwUv/8a92HPctzwH+i1RQmEVY39+spqt
	v2mJ6rh4OwKEjEHWEUaGUa86KwzCdGXSLjJ4o21iVELdYlzypFVKub+KCaulaMz8Qw5PCnyc/qu
	bdLyGktKr6r9a/N50KTzaj2pLhTOK3s5muQ==
X-Gm-Gg: AR+sD12vB7l0K98B6D4gLtxPglOffvWRdEvnpbnwbFNTzvDjgLJRM4bmqEV1jSHbP6r
	/HMZGMI0U0VCSYiVQAVxn/Tfpuy/MnXI9+Ew07qiR5dqxBnEDvO3kdgmAOHKtFmy83S1gT6jrbg
	xKBgg5NnVypnjJ5pojo2OdrqQwgMpbCj3tCiNGYCOQ9KNTHP0IsMaOKsD9hVoZrTq4vRFyBdbr0
	kz/OASOAxyPOLtUHGq5b1WxOItRkk8T43LF57mdFOiDcusshtFwsVZE1u1tARcBw0E41gTInKfZ
	V+Gj0tHirDQ+iu3uFBxGT2heNT6bng==
X-Received: by 2002:a17:907:97cc:b0:c15:f6b6:18f4 with SMTP id
 a640c23a62f3a-c1f1ed40564mr75174166b.24.1784981074298; Sat, 25 Jul 2026
 05:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624132356.516959-7-puranjay@kernel.org> <20260724183123.160051-1-puranjay@kernel.org>
 <5a87e5f1-7cbf-45c0-a6e2-88320db628bc@paulmck-laptop>
In-Reply-To: <5a87e5f1-7cbf-45c0-a6e2-88320db628bc@paulmck-laptop>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Sat, 25 Jul 2026 13:04:21 +0100
X-Gm-Features: AUfX_mxztUek5QzrvnuWv513tANm2vUvNcHIsu0rIcLDMCQdR_8_cVOv82niJL4
Message-ID: <CANk7y0jZ7JuR6MoNKZZU3R=+kfe0pELRUWYomtxHKQwsBan3Bw@mail.gmail.com>
Subject: Re: [PATCH v2 6/11] rcu: Enable RCU callbacks to benefit from
 expedited grace periods
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 1:23=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Jul 24, 2026 at 11:31:23AM -0700, Puranjay Mohan wrote:
> > Currently, RCU callbacks only track normal grace-period sequence
> > numbers.  This means callbacks must wait for normal grace periods to
> > complete even when expedited grace periods have already elapsed.
> >
> > Use the full struct rcu_gp_seq (which tracks both the normal and
> > expedited grace-period sequences) throughout the callback
> > infrastructure.
> >
> > rcu_segcblist_advance() now checks both normal and expedited GP
> > completion via poll_state_synchronize_rcu_full(), and becomes
> > parameterless since it reads the grace-period state internally.
> > rcu_segcblist_accelerate() stores the full state (both sequences)
> > instead of just the normal one.  rcu_accelerate_cbs() and
> > rcu_accelerate_cbs_unlocked() use get_state_synchronize_rcu_full() to
> > capture both sequences, and the NOCB advance checks use
> > poll_state_synchronize_rcu_full() instead of comparing only the normal
> > sequence.
> >
> > srcu_segcblist_advance() becomes a standalone implementation because it
> > compares SRCU sequences directly and cannot use
> > poll_state_synchronize_rcu_full(), which reads RCU-specific globals.
> > srcu_segcblist_accelerate() sets the ->exp field to
> > RCU_GET_STATE_NOT_TRACKED so that poll_state_synchronize_rcu_full()
> > compares only ->norm and ignores ->exp.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> > Paul, please take this in place of the original 6/11.  The only change
> > from v1 is dropping the premature !poll_state_synchronize_rcu_full() ga=
te
> > in nocb_gp_wait(): if a grace period completed between rcu_advance_cbs(=
)
> > and that poll, the rcuog slept grace-period-deaf in nocb_gp_sleep() wit=
h
> > advanceable callbacks still queued -- the lost wakeup Frederic diagnose=
d.
> > Verified by widening that window with a delay: the original reproduced =
the
> > writer stall within ~75s, this version stayed clean.
>
> Done, and will test during the weekend, thank you!
>
> There were some conflicts, so could you please double-check?

I have looked at your latest dev branch and everything looks good to me.

Thanks,
Puranjay
