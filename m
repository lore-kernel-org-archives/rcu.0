Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794452639;
	b=I8XBa7QfDB0zarrFYV3z1WaV5gUmVO09zUMmV3XzievGMs/D1yz7JdIzhYBSGwU2PODd
	 lc2iG1KDVRV17f7TuX16C0eJGJSHWJe8pEPXBLo2cEZAr6Nmd+8jQYs/ZFZaxJT6jqPOM
	 Fe8mocx60jQ43RkexxUVdpA3MC9eHZa3NHJvWdqaQJ8iGojZ5gE4WR1X1WmILw6pmoFaw
	 ceqeVi4kvDo3eshrY9hubenrqZxjMlev53Ta7mDFjl1bfo6N4/b9rf2yO6KHo/qXGujI8
	 uOe9kPo+eS8D3LJm90heaUbo+1g0plm4t+D7em9ubkW/iKdROKQr4ztGaJ4t5pC2aUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GTeGZu2+9xZSrtftnB09MXJ0s6NLQku+8Y5vW10jAeo=;
	b=4ij18pke4F/8xUiuy9i86dcpVpmTCh95WtjhbtuBCywd5goMSjAuC3vCIGuhEZKntOoo
	 0R01iGFnbsFEzAYQKdywWKxvJYk+4GjZnmbPIQUFxJ6s9DQpxXRRI99XuV7AkqAIqaBkv
	 49Ca6/O4VoCxwGZRZmVgSHMDF/kbmO4kTPLAN7AnhVnF3vnGmLoRWWoe5BkyoSHso9C/u
	 YZCcet1qpENrQPqtysZWCFLMauUt9I58kph3J5zYTJreEW78BWvo9LlJT7b/kipY+IVZG
	 LlHVfni7pzIO+7oo+cyOtx8OZYx/7Rs6u2uwF00sbxxEuvH9hfKuPd3f4IjEZ6UWqvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NYWQ+ASk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD51606A31C
	for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 03:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BD51606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NYWQ+ASk
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso33391725e9.3
        for <rcu@vger.kernel.org>; Wed, 11 Nov 2026 19:03:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794452637; cv=none;
        d=google.com; s=arc-20260327;
        b=pXmIZXHl7Xnd2omjJqf3mNSpe6OR98MCSokq5D5O9QSifxPR0w9dv+OcpgzGLF2luG
         M05LUlth0c9UlxIKrJPkTvsOSzew2Gz5aNGh9eOicQe6ICE/p7VFoKbK6yb035Cc73tn
         l0T7kNuLic8ZFwh36vUiI5Xqx7PwWkZ4+qmJXqPFmqGp2o4+TC9c/AN3LisrpdEoGsnL
         KToL87eKDbcM5UEdFfU2GqUkvrEgSVosFFBWfkDiJT3ACLnBa03sJwb3eIKDXCztvJzp
         EtSxnGk+xBR5iWrJFukaOopPgjUreWHA1Wj811xR2589+f6L1LxhMqcKxfohQxPARABC
         zjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GTeGZu2+9xZSrtftnB09MXJ0s6NLQku+8Y5vW10jAeo=;
        fh=8xOghna1WPiC0cucwKIGb62jkbZy4vOumF70k1qDd6g=;
        b=GJgXqp3C/GqeiXOrOVf0g4+3DsRL+Y2/Jb5WcaxTzhZ0jfg+Jf35p/qst5bVZHnNOT
         zsgAhMSqvNtzbc2V3Vfz7CRt4Nso9f5EKAqSA1ZKy0u7e/yUgdMZo1MpDImoy/EqHoE6
         nunKTj73Aai1+gG8keDsfKPubD6sBbuP72IdrXFI6avfi1/Dyttbatswzgn2lE9TDI5G
         /+3G+2Ffo6gSoVfh7y4Be+DbFIqoYjwYqRFLnGak5AZYcgy8QJKVsB1K/YkOgXFhXT0K
         69pxxvH+QBMNe7t4Z2DQ5fus6tPa+TMZ03N8jf/HJCM2nyAtXDYuAMqbs9iFBSVSh/CC
         qDLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794452637; x=1795057437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GTeGZu2+9xZSrtftnB09MXJ0s6NLQku+8Y5vW10jAeo=;
        b=NYWQ+ASkcj3iXlWnKEe9C54SGHbNXuCQpbfPm5kHOQWlr00Vvts9RWWSScfoYWBhei
         ABVydHzxQpQpz9CFkW+x+vIRmXP6tsCnb8FsZe4AtYu/QCtFAN1Lywiav+VRirHbiAnq
         E/3SWKWrfYKIUpcwgWTL76XevBO5cTZYDITBGiKw/47BBRNaoJ5bzgM5KSnroNHMUACv
         q2ZLQ9b6Q09XPcZzbzTqhjgVhS3o3pgxelaEsMmG1enjZaUqtvQ3hqBJk3Dj2BnBjAj+
         MP8iMKPAy8tzdpT30gE8HbFp/jdvSjztkiVHLAV+xKlQZoqY3wjFH7c+DKHqCS0Otjys
         dSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794452637; x=1795057437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GTeGZu2+9xZSrtftnB09MXJ0s6NLQku+8Y5vW10jAeo=;
        b=o3j7nwAmOtBLWpZn93JCM0xuGRBYcO+nl3lHQFvegX6rvBKP16xkNYzu4GMEX++tfk
         EnEUzS3pKTSNGP0iYRFdHr1oFfWL1Uy8LZVfWGRHyNfq94LgdP2Xmj/WiAwMaO1jlNx8
         YAB41AFEeMhtFxfHzQTkymOLXNTKF+p0/1aVr5mvNbvSHbpCP6Si2GJWEoF7Q1jlsvxO
         p/ALovY7RkFpRER9VAW73kQREidNaOgznTTvbRwKnd+INJOOdPzPKMCaBoKymKl7wVu1
         jyD+m742eKJqkXOsT4iafk5ItQdPpEHqsDBcVxZ7xMxVQRIdUZGuDnRNuDhsQNvkKWTg
         cIMw==
X-Forwarded-Encrypted: i=1; AL+hErFApSgOOTGtw4Vavw52Zo+EPEVagi5zLJus9L8v8akJleNkHpdeU87HNqq8XmufbqdNxjI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/03DzRpHT8eTSbe/NV/i3j1Oh0a9TgSmWSfTK1mJVDH2sqmBG1
	o1BPSToA9iXZa1FBke9zcz/adhyeszIlYlU1PixdhU8OxxF+ZkH4GzEN6ob6fELBHLK5+Zpjfk5
	LfA/PPHvrGYBZsxnUyjQ1vy600+JMfZE=
X-Gm-Gg: AYBFou3LH/kz4MAi5jKQ43R5WxsZ1SAt4JkzzjKMWEfHCMaCZZAvDnF5jfCNQ/M9AsP
	AZIOOsTWeeGFrsDu/ws7FyI8dY3du8zI5jtCkC6abEfA8Nka+CBXRf92q32U0uCaKszI0CMXnHy
	SZmcHsAxhw8aEHN8yxyoUO0jpasZqz2jWOLx24Ab5fVewGHtLA88bz0IdcDIO8D+V9mZUHURO+I
	AZQQwTXPRsLVBPDaqTyPbDv37iKJuauAXb7oN60oGT595mB1JZuDiXQ0DD4AXZKC9IRhiaHvSC0
	B8vEqr0BxKry/S6vae0ZSMjJTYOXgnYgJr/+9OgSHWt3Mv8fe5sRITjbmKkgfqkHh5RDiOAk2lF
	YNS/96jn6kieJWGsIuo4+kxsRG6A+A7pAlFM72A==
X-Received: by 2002:a05:600c:6089:b0:4a2:1612:637a with SMTP id
 5b1f17b1804b1-4ba09376ccfmr70937035e9.16.1794452636496; Wed, 11 Nov 2026
 19:03:56 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com> <20261111145949.70845-2-mathieu.desnoyers@efficios.com>
In-Reply-To: <20261111145949.70845-2-mathieu.desnoyers@efficios.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 12 Nov 2026 11:03:44 +0800
X-Gm-Features: AclHuK-9md0vcPevHW5yCaXCA8-TIbsg6XxGXtCuTXXP4lXtaJiSsteqqebRV7I
Message-ID: <CAN_Opa-j6weQV6G1191vDG7hq2kkOfuGF=i83zpRQLvfo8cfwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] srcutiny: Do not call synchronize_rcu() from synchronize_srcu_atomic()
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Davidlohr Bueso <dave@stgolabs.net>, Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Mathieu.

Reviewed-by: Kunwu Chan <chentao@kylinos.cn>

On Wed, Nov 11, 2026 at 10:59=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> synchronize_srcu_atomic() never blocks, so that it can be called from
> atomic context.  This includes interrupt handlers, and code within
> rcu_read_lock().
>
> With CONFIG_PREEMPTION=3Dy, the Tiny SRCU version first calls
> synchronize_rcu().  Tiny synchronize_rcu() does not wait: it only
> advances rcu_ctrlblk.gp_seq.  This is valid where the caller is in a
> quiescent state, in task context and outside of any RCU reader.
>
> The callers of synchronize_srcu_atomic() need not be in a quiescent
> state.  An interrupt handler may have interrupted an RCU reader.  A
> caller within rcu_read_lock() is itself an RCU reader.  In both cases,
> synchronize_rcu() ends an RCU grace period while an RCU reader is still
> in its critical section.  poll_state_synchronize_rcu() would then
> report a grace period that did not happen.  The caller within
> rcu_read_lock() also gets "Illegal synchronize_rcu() in RCU read-side
> critical section" from lockdep.
>
> srcu_drive_gp() has the same call.  There, it makes an RCU Tasks
> Trace grace period imply an RCU grace period.  RCU Tasks Trace uses
> call_srcu() and synchronize_srcu(), which are both forbidden on a
> srcu_struct that uses synchronize_srcu_atomic().  And the Tree SRCU
> version of synchronize_srcu_atomic() does not wait for an RCU grace
> period either.
>
> Fix this by removing the call.
>
> This was found by reading the code.  An rcutorture test added later in
> this series fails without this change.
>
> Fixes: a48669f0c49c ("srcutiny: Add an atomic Tiny SRCU")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  kernel/rcu/srcutiny.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 63a3f0a8bc53..d58f4160f925 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -367,9 +367,10 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp=
)
>         if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
>                 return;
>
> -       if (IS_ENABLED(CONFIG_PREEMPTION))
> -               synchronize_rcu(); // Needed for RCU Tasks Trace to imply=
 RCU grace period.
> -                                  // And in Tiny RCU, it is near zero co=
st and doesn't block.
> +       // No synchronize_rcu() here, unlike in srcu_drive_gp().  The cal=
ler
> +       // may be in an interrupt handler or within rcu_read_lock().  Tin=
y
> +       // synchronize_rcu() would then end an RCU grace period that an R=
CU
> +       // reader still holds up.
>
>         // Usually, there will be no readers.
>         preempt_disable();  // Guard against lazy preemption and some oth=
er grace period.
> --
> 2.47.3
>
