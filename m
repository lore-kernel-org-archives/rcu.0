Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C54FB9DF
	for <rcu@vger.kernel.org>; Wed, 16 Sep 2026 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565914; cv=pass; b=ZpUFnW1vBK8KT2eUjJiwQhoHz04uZB9l6o6O/qx8cExVEeQ4nApMroCxKater+FE4aqd/Vb4Ztt/zQm/CR5eZYpTs90rN075/k30ReuLA8EdS2FnB41aqDeZ3YS1FyppAO6jM+2/1blWdJFRa1WWJkoUKnePYwwyg5VZ1rddWow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565914; c=relaxed/simple;
	bh=VxVVFUrZNYmDxtHauKu16hNl8SquobegkBvEi2oGCpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2HWG3lhF7sNltIs6fSqYneBh1/fxio3qqPj3LeTMuh+74TGrJh5kz32jMqQL2fx+IqQUCe6X4XRxq4Y7/W0No1Af8d9MpApwRbz2Eu9by8IFl3ykecJ1bcHnfEg6T/8pAYryKl5PdS3BdG4qYF8x3k+SJdbqLh/QlMEXRXo7Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goxpIBE3; arc=pass smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goxpIBE3"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a5e21a5408so2498721fa.0
        for <rcu@vger.kernel.org>; Wed, 16 Sep 2026 06:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789565886; cv=none;
        d=google.com; s=arc-20260327;
        b=hWTjIRav0yJQZ/j6+QwCDFQ12qqDbbAJy+F0lnT27HI6wJP0O/FsRFC4oCFdqWerha
         bIWBZzonvROLBZBvSzib3IMx83fOodboLdjAQgFzzGid4aXuIH9M4CfhT4g/+QUG9y/k
         9pYl1WJ/QPjYtrbazF44X9NbnP4dZzEFnSU3zMRMYLM0oJ1mjrYJ2Wr6aLuX6AHeEZyP
         6JIeSSVAxjy16xvwTwBtJrKU3thJd1iEC+aBMcIsdM6B1ftPPsEdkSFu+IqUDLdlcAAj
         vb/os8rVhTyEYowX0kF6HreaAYLyUsmLmYNDA48YBAzz07xEeRC0vzLCjquWsWathlkY
         MsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j0teu7xp+BkcAacjp7xSCRSnLwGlM0PRADY07dogivo=;
        fh=Mrdmzg7890tWcXDFXFkDTWYaINftA9vu4Ga3uyODlMw=;
        b=Nr/QuUSkk2EGcW3AhJg8FogJEwzWzkuDAVyVLdWdOvqMgBrXxe+rSGE7k/Yanu9OO4
         Xwl/iZA2V8PFqIeGQL99B6Vh1UmkvuwwqsmUS/y3/Fhzs1wOjS01AsOs4AfbPzfmsNxP
         zTPw8j+gH3LwIcJSpE0XYRXmCz0/hM8OCYGrEcguCnhO+IjiOMpQO/qg1GZj31HHGOIh
         8poVljZ6PG84XU6ssp0H0H2BBxrNRrg22ttKZhP8GsAQjMTyNfyu5A83iJdOcfcwDs4e
         0hhgQeDBGBFoB1+yclt3YHEFR44+MjlfDGTqIgzOdHx9yIgiRNl4mS9A17+e1ZeLquLL
         4p+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789565886; x=1790170686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j0teu7xp+BkcAacjp7xSCRSnLwGlM0PRADY07dogivo=;
        b=goxpIBE3+1Wl7dZugsuyulcfdqNX5EMpXYHKkEWt9MeUBHSgVmx8J8Gwhi9M4Nrurj
         pYJ3GWfBLKeRAVTKNaibMrgyQbLcBIoiMMvNx9cZ1NtgXWPupXI7Xz7q4Fo9wvomgEk5
         agakTinOSanKjRGFQs5e++o/8UCLmlFznB4xQ6dixJJiSu0k3RaYnG27iqGpqvFUZfOA
         94+MVwhBxTCa5DLk/EOD/O9ygL/+Wm6smrKC8ydLkw8zbzVZNJgBe7fAfF+M4YCwyIdK
         rk2G9tdCCX3u0h5JSFrfVzJ0P3AA96pINaSWDevEZo2k/iM1AJrfkOOjDjy2wWmqssTa
         V4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565886; x=1790170686;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j0teu7xp+BkcAacjp7xSCRSnLwGlM0PRADY07dogivo=;
        b=P3Dl5Taw3PecYFI7I/lFSat0t+RkeJ+NJLFFp01TtjFeOfy/wP+CBM7zF22a0I2p/4
         eBWHIl2tAGQ4Li+JFEfvp4h9wLO2CKnLNPr8eDCvl1pEw7LkHjK3KaDiHsffYsQKAJFe
         sglxLhuyE6DzBoDrF5kic+U5fN7l/2YDO5Wy0r14c1O7elTusMISxtDlpgNc9WYuJ+C5
         7AJLxSR5Kz+arZyQlC9wAc5/NI0pr5icViQVi7PVwU6oR44KdQXx7hUYcFdzzx/U8St7
         +5TUBVLEjOQ0Eu7fDsWMT/+ZOZEU6segLmm0Lkm2V4yrLu5qOSW/LU+zGoWRfMb3VAkr
         dzsg==
X-Forwarded-Encrypted: i=1; AKwUvByVkM0fqx3qOAYZRc5V1GvNzckK59Oaj8Cph5NiiuVMGdGfMFiotGEFTGDtGIsP0ZLZPFo=@vger.kernel.org
X-Gm-Message-State: AFuF++n4go5dGZ8Hpbv3DI8m8ftFISUFc0laG/Ar5LmubSecLZRf02Bu
	9TzpDZ1A3dT357o0SvffiOwrEOX9ojuNcxS6+W1myXIvs5uxijwCjL9WSdWIfwHKRO/8l/Ie5Ir
	7sQE9mFvVCOlI8BONIpgNBrXZ0cG4ukg=
X-Gm-Gg: AYBFou3dDNkClVzdst0YRoaVqqpwSnbACUGxCIFaYk0yYiaD3rtDc4JWf+6QOZXxYrz
	Q5qlWDyUvI0CrM4h/D1k7Zp9hjoi2Im1cyk81k5zLT44rzqIRyC/9qLc9znluKxsBhmgq40D36B
	jYPntalgSxGtsNuA7lccnQZjZuYc7YJKgBjw/xGCNP80FWbK8lZoA47wbeC020M16aXR1fKg3BY
	3gaf8u6+kGGqR12ClxXxg9ZVusX82fBUNQk4vkfW1VA/0B5HgHnJoyCvSrf/vAnzYWfHuku3LdB
	ZmErCBM/sCEHn9gjxFLwv2FbjI6BoA7l+JShCBWPPFkLhNKwMLK2GMdt
X-Received: by 2002:a2e:a7ca:0:b0:3a3:2a41:c0c4 with SMTP id
 38308e7fff4ca-3a5dca30ebemr5052221fa.14.1789565885882; Wed, 16 Sep 2026
 06:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105032112.1156359-1-dolinux.peng@gmail.com>
 <483ad434-4512-442e-ae6c-4108d5af5e49@gmail.com> <ea36a1e2-2940-4385-9b1d-fb197f1b562a@paulmck-laptop>
In-Reply-To: <ea36a1e2-2940-4385-9b1d-fb197f1b562a@paulmck-laptop>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 16 Sep 2026 21:37:50 +0800
X-Gm-Features: AcwNN1XGYkOqKrLXqV4AV69JFjHJ2lwKLnzFZ5CH-17qpLfCXzKgAHHJYjVSwSg
Message-ID: <CAErzpms_CF5V+3T0i=iG9p7Q5uQS1287whvOe9iXhFkAGvE90w@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Align stall warning 'idle=' output with documentation
To: paulmck@kernel.org
Cc: joelagnelf@nvidia.com, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	qiang.zhang@linux.dev, rostedt@goodmis.org, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 12:06=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Fri, Sep 04, 2026 at 08:24:05PM +0800, Peng Donglin wrote:
> > On 1/5/26 11:21, Donglin Peng wrote:
> > > From: Donglin Peng <pengdonglin@xiaomi.com>
> > >
> > > The RCU stall warning message includes an "idle=3D" field to indicate
> > > the dyntick-idle state of a CPU. According to Documentation/RCU/stall=
warn.rst,
> > > the hexadecimal number before the first '/' represents the low-order =
16
> > > bits of the dynticks counter. An even value denotes that the CPU is i=
n
> > > dyntick-idle mode, while an odd value indicates otherwise.
> > >
> > > This was valid until commit 171476775d32 ("context_tracking: Convert =
state to atomic_t"),
> > > which merged the context-tracking state and dynticks counter into a
> > > single atomic variable. In the new layout, the dynticks counter occup=
ies
> > > the higher bits starting from CT_RCU_WATCHING_START.
> > >
> > > However, the current stall warning code prints the value from
> > > `ct_rcu_watching_cpu()`, which returns `atomic_read(&ct->state) &
> > > CT_RCU_WATCHING_MASK`. This masks out (clears) the lower state bits,
> > > resulting in a value that is always even. This obscures the CPU's tru=
e
> > > idle state and makes the output inconsistent with the documentation.
> > >
> > > To restore consistency between the code's output and the documentatio=
n,
> > > shift the atomic value right by CT_RCU_WATCHING_START bits before pri=
nting.
> > > This extracts and displays only the relevant dynticks counter portion=
,
> > > allowing the parity (even/odd) to correctly reflect the CPU's dyntick=
-idle
> > > state.
> > >
> > > Fixes: 171476775d32 ("context_tracking: Convert state to atomic_t")
> > > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > > Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > ---
> > > v2:
> > >   - Use CT_RCU_WATCHING_START to replace ilog2(CT_RCU_WATCHING) to cl=
ean
> > >     up the code, thanks to Zqiang.
> > >   - Clarify the commit message.
> > > ---
> > >   kernel/rcu/tree_stall.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > index b67532cb8770..fd9d7fd6e17c 100644
> > > --- a/kernel/rcu/tree_stall.h
> > > +++ b/kernel/rcu/tree_stall.h
> > > @@ -555,7 +555,7 @@ static void print_cpu_stall_info(int cpu)
> > >                     rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' =
:
> > >                             "!."[!delta],
> > >            ticks_value, ticks_title,
> > > -          ct_rcu_watching_cpu(cpu) & 0xffff,
> > > +          (ct_rcu_watching_cpu(cpu) >> CT_RCU_WATCHING_START) & 0xff=
ff,
> > >            ct_nesting_cpu(cpu), ct_nmi_nesting_cpu(cpu),
> > >            rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
> > >            data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gps=
tart,
> >
> > Gentle ping on this patch. Thanks!
>
> The advantage of the current code is that the CT_STATE_KERNEL,
> CT_STATE_IDLE, CT_STATE_USER, and CT_STATE_GUEST information is visible
> in the lower two bits of that hex number.
>
> Now, if you wanted to print that information symbolically and then
> shift down the counter, that might well be a valuable improvement.
> Given corresponding updates to stallwarn.rst, of course.

Thanks, that makes sense. I'll print the state symbolically, shift down
the counter, update stallwarn.rst accordingly, and send a v3.

>
> Or am I missing something subtle here?
>
>                                                         Thanx, Paul
