Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99018FDCE
	for <rcu@vger.kernel.org>; Wed, 29 Jan 2025 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192226; cv=none; b=KgvtoDmdkN+PNXcCaIfWIP8L8mQidG3gHQMGeKYyVvw7RS1AlOkSJMHYK+tV2if7n5YZt0tk+mMm43hKchQhXg7Cjq/ml+5vL9w/6VgbrA/4QPKEofCmY05VsrEt10WoEkgv7+oGipV0EWC6ulDlGUucUv5KOjAkqCKdynOMdu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192226; c=relaxed/simple;
	bh=SePUdbN/YTAAEEp3PJAxcxCJFkbFsQtAZL3FbbSh30k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAuJ+w0/f+W+AhotcYiKr6eGxYynczRGJ3egXivbLytNBKK57qGynoY7cfCamI7Qr4lyMcyGnCkzgwjiGl1PqdmQAl0jO9u0DEsC465rC9FAqw2KX//f1GO1Iv8tpfFoAWY8SyauldrliG3y7nikZ8J84ASH6y+7ii3H3us6iQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=GOJ3L3d2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="GOJ3L3d2"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43618283d48so898015e9.1
        for <rcu@vger.kernel.org>; Wed, 29 Jan 2025 15:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1738192222; x=1738797022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dt/34B+hMZb+wBIW0djF98uU+EiPyrFtGRjrOvMVlzI=;
        b=GOJ3L3d2Oeq1+yBRQFo6F7cZU6skC6aaNNPe85FW8WLnG9sHmccj8MmCbFiZYCMTAm
         3edzoyAex/DPsHLqW7//bj8GbyVo32rZ8lzEE7HIDcpunS2Lff9QdWKTE3zzT6j0xqYb
         D5726IGC7xeAIwOUmAvhqoOJcUWy2yuhOAJv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738192222; x=1738797022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dt/34B+hMZb+wBIW0djF98uU+EiPyrFtGRjrOvMVlzI=;
        b=dexXeYEH3y4px88gX6aLRfA2H326EjlquegUV1gEG16+bFSKZDk/EIaNtvQG+qJuhC
         h9a43qfECrWyxlf3U5z2ig/C10zXzFsjk6Z+LAKZ3jvg54I98rFv76dAzZ3Y6DX93taq
         j9ZUJ0mEipte+AU/BYU/h6mZzx3IoEsMEQj0NT3ar3WBif6xoS3wCTV08nzAckJnq+yn
         zwkR4NYxNEU6r1H4QmrLCWD8pvQvhyIa73/h1HPZUF73dDKiOtfmOBKeHKy0Z5uqLxq4
         7LhVKlApB3/aF6aeiTKhW71m2rnLxGi9Gp3MjxrfXlLwmLy8BUlYkI4i7BmCpW2VB8sd
         TaNw==
X-Forwarded-Encrypted: i=1; AJvYcCWvpD0yL/K2dRV1xovAS+rJtjTYC6mXoCvRd3GS5nQLuM5OiO37MKvMQzJCfsx8YpVyF3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIZhidBfGbLLb2ynWS/2iAX/WAI+grjimnRVLNAyCce7QnPoAc
	dqaOSwplNlbx8ZEECAiU5YAnT5/Wc3L55FpCAgEZr4A3i+rFDwjgykk0NBFxvEhKN3aHQUJp9g8
	ekJoSgGNCdvtJFtIHBfn5lug9eLcRYXevv3U9Dc447r61mSB4Pi8=
X-Gm-Gg: ASbGncv+k2CpQPRkBAJtNh4+2i78Hq6sVQq4cKDOJ7XXpdNutk2OSCYJCR0O9zwtpRx
	jSnMKG7+7e9Z7j8bcHLoaC1quGewHU7XYMXZH+kiIKGC2oOQoO9n4TStDnq56kZSte2CD7cbpKQ
	==
X-Google-Smtp-Source: AGHT+IHZha7mK2uyJYV73CJ5+VdotlW8+eF8eHk6+1qGQ+KAdmQHWPUOGeZdBcbTXlatCWopx0qB81ZEJHD5+gqHyqE=
X-Received: by 2002:a05:600c:5119:b0:434:f917:2b11 with SMTP id
 5b1f17b1804b1-438dc40bd8dmr37467895e9.21.1738192221842; Wed, 29 Jan 2025
 15:10:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ecce7241-4238-4d86-8e4c-5080937129ce@paulmck-laptop>
 <15D1150A-9B7B-4EB7-91C6-2D881D6F48DA@joelfernandes.org> <861f1dc3-bfc0-4a81-9b78-c8e9995db4cd@paulmck-laptop>
In-Reply-To: <861f1dc3-bfc0-4a81-9b78-c8e9995db4cd@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 29 Jan 2025 18:10:10 -0500
X-Gm-Features: AWEUYZnFVNqqySqM8AfvcNsTZJv3Fpw3Ni9vlsRAyjRk2HH754MGWgglJFeg0z4
Message-ID: <CAEXW_YQ4W=upWV_x1woSgq-DJPFXmBjH2pVmUnBVb_n_UKrw7A@mail.gmail.com>
Subject: Re: [PATCH] rcu: Merge rcu_seq_done_exact() logic into rcu_seq_done()
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 12:25=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Wed, Jan 29, 2025 at 06:34:53AM -0500, Joel Fernandes wrote:
> >
> >
> > > On Jan 28, 2025, at 9:21=E2=80=AFPM, Paul E. McKenney <paulmck@kernel=
.org> wrote:
> > >
> > > =EF=BB=BFOn Tue, Jan 28, 2025 at 09:13:45PM -0500, Joel Fernandes wro=
te:
> > >>> On Tue, Jan 28, 2025 at 8:47=E2=80=AFPM Paul E. McKenney <paulmck@k=
ernel.org> wrote:
> > >>>
> > >>> On Tue, Jan 28, 2025 at 08:38:57PM -0500, Joel Fernandes wrote:
> > >>>> On Tue, Jan 28, 2025 at 8:33=E2=80=AFPM Paul E. McKenney <paulmck@=
kernel.org> wrote:
> > >>>>>
> > >>>>> On Tue, Jan 28, 2025 at 08:22:48PM -0500, Joel Fernandes wrote:
> > >>>>>> On Mon, Jan 27, 2025 at 07:09:34PM -0500, Joel Fernandes wrote:
> > >>>>>>> On Mon, Jan 27, 2025 at 7:07=E2=80=AFPM Joel Fernandes (Google)
> > >>>>>>> <joel@joelfernandes.org> wrote:
> > >>>>>>>>
> > >>>>>>>> The rcu_seq_done() API has a large "false-negative" windows of=
 size
> > >>>>>>>> ULONG_MAX/2, where after wrap around, it is possible that it w=
ill think
> > >>>>>>>> that a GP has not completed if a wrap around happens and the d=
elta is
> > >>>>>>>> large.
> > >>>>>>>>
> > >>>>>>>> rcu_seq_done_exact() is more accurate avoiding this wrap aroun=
d issue,
> > >>>>>>>> by making the window of false-negativity by only 3 GPs. Use th=
is logic
> > >>>>>>>> for rcu_seq_done() which is a nice negative code delta and cou=
ld
> > >>>>>>>> potentially avoid issues in the future where rcu_seq_done() wa=
s
> > >>>>>>>> reporting false-negatives for too long.
> > >>>>>>>>
> > >>>>>>>> rcutorture runs of all scenarios for 15 minutes passed. Code i=
nspection
> > >>>>>>>> was done of all users to convince the change would work.
> > >>>>>>>>
> > >>>>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org=
>
> > >>>>>>>
> > >>>>>>> I am leaving a 60 minute overnight run of all scenarios on my p=
ersonal
> > >>>>>>> server for further testing.
> > >>>>>>
> > >>>>>> The run passed, details below:
> > >>>>>>
> > >>>>>> --- Mon Jan 27 11:49:49 PM EST 2025 Test summary:
> > >>>>>> Results directory:
> > >>>>>> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --durati=
on 60
> > >>>>>> RUDE01 ------- 14309 GPs (3.97472/s) [tasks-rude: g57884 f0x0 to=
tal-gps=3D57880] n_max_cbs: 0
> > >>>>>> SRCU-L ------- 34121 GPs (9.47806/s) [srcu: g316564 f0x0 total-g=
ps=3D79242] n_max_cbs: 150000
> > >>>>>> SRCU-N ------- 151316 GPs (42.0322/s) [srcu: g1840064 f0x0 total=
-gps=3D460117] n_max_cbs: 150000
> > >>>>>> SRCU-P ------- 35189 GPs (9.77472/s) [srcud: g320792 f0x0 total-=
gps=3D80299] n_max_cbs: 150000
> > >>>>>> SRCU-T ------- 389034 GPs (108.065/s) [srcu: g4142406 f0x0 total=
-gps=3D1035602] n_max_cbs: 50000
> > >>>>>> SRCU-U ------- 376267 GPs (104.519/s) [srcud: g3953834 f0x0 tota=
l-gps=3D988459] n_max_cbs: 50000
> > >>>>>> SRCU-V ------- 407633 GPs (113.231/s) [srcud: g4371704 f0x0 tota=
l-gps=3D1092927] n_max_cbs: 1000
> > >>>>>> TASKS01 ------- 11007 GPs (3.0575/s) [tasks: g57816 f0x0 total-g=
ps=3D57808]
> > >>>>>> TASKS02 ------- 10539 GPs (2.9275/s) [tasks: g57936 f0x0 total-g=
ps=3D57936]
> > >>>>>> TASKS03 ------- 10453 GPs (2.90361/s) [tasks: g57508 f0x0 total-=
gps=3D57508]
> > >>>>>> TINY01 ------- 511634 GPs (142.121/s) [rcu: g0 f0x0 total-gps=3D=
0] n_max_cbs: 57078
> > >>>>>> TINY02 ------- 541799 GPs (150.5/s) [rcu: g0 f0x0 total-gps=3D0]=
 n_max_cbs: 2619
> > >>>>>> TRACE01 ------- 7299 GPs (2.0275/s) [tasks-tracing: g45844 f0x0 =
total-gps=3D45844] n_max_cbs: 50000
> > >>>>>> TRACE02 ------- 101265 GPs (28.1292/s) [tasks-tracing: g305464 f=
0x0 total-gps=3D305456] n_max_cbs: 100000
> > >>>>>> TREE01 ------- 97989 GPs (27.2192/s) [rcu: g479473 f0x0 total-gp=
s=3D120151]
> > >>>>>> TREE02 ------- 202908 GPs (56.3633/s) [rcu: g1459509 f0x0 total-=
gps=3D365162] n_max_cbs: 1139244
> > >>>>>> TREE03 ------- 168901 GPs (46.9169/s) [rcu: g1764445 f0x0 total-=
gps=3D441393] n_max_cbs: 1341765
> > >>>>>> TREE04 ------- 148876 GPs (41.3544/s) [rcu: g951744 f0x0 total-g=
ps=3D238225] n_max_cbs: 236765
> > >>>>>> TREE05 ------- 220092 GPs (61.1367/s) [rcu: g1234385 f0x0 total-=
gps=3D308880] n_max_cbs: 82801
> > >>>>>> TREE07 ------- 34678 GPs (9.63278/s) [rcu: g207257 f0x0 total-gp=
s=3D52094]
> > >>>>>> TREE09 ------- 341706 GPs (94.9183/s) [rcu: g7693569 f0x0 total-=
gps=3D1923688] n_max_cbs: 1845334
> > >>>>>> --- Done at Mon Jan 27 11:49:55 PM EST 2025 (4:41:24) exitcode 0
> > >>>>>
> > >>>>> Very good!
> > >>>>>
> > >>>>> How would you go about analyzing whether this is really safe vs. =
getting
> > >>>>> just getting lucky and not having provoked an overflow?
> > >>>>
> > >>>> I would probably add a more specific test case stressing the API, =
or
> > >>>> even a unit test of just the API by passing a range of sequences..=
 I
> > >>>> should go ahead and do that but it sounds like you feel there is a=
n
> > >>>> issue with the patch? :)
> > >>>
> > >>> 2^31 (let alone 2^63) is a very large number of grace periods, and
> > >>> so it is hard to test grace-period sequence-number wrap.
> > >>>
> > >>> Not impossible, though...
> > >>
> > >> We could test a decent number of candidate sequences to cover
> > >> different cases. Not ideal like bruteforcing, but...   Another idea =
is
> > >> to hardcode/assume ULONG_MAX as 16-bit in a unit test.
> > >
> > > Or put the various sequence numbers into an unsigned short or even
> > > an unsigned char.
> > >
> > > One set of use cases checks to see if a given CPU's ->gp_seq has fall=
en
> > > too far behind the current grace period, and sets a flag to alert
> > > that CPU.  Others rely on a false negative being functionally OK.
> > >
> > > Or so I believe.  ;-)
> >
> > Thanks, I am itching to create a visualization of all eight bit combina=
tions and the output of both API, which will be a fun exercise however I=E2=
=80=99m missing something fundamental because as I mentioned in that 100 an=
d 200 example, the API itself cannot distinguish between a wraparound and a=
 legitimate delay in comparison between start and a delayed end. I need to =
understand this better and go through the code more. ;-/
>
> The big questions are "under what conditions does it need to distinguish,
> and what are the consequences of failing to get this right?"   Also, "wha=
t
> is the purpose of ->gpwrap?".

My understanding is we take a snapshot of a sequence and then check at
later time if it was reached. Ok I shall explore these questions.
Meanwhile I created the following visualization using 5-bit numbers:

https://drive.google.com/file/d/1w2sgJga7B5dye4iH0oPZ79obaKO-e_Jn/view?usp=
=3Dsharing

I find as we expect, that for rcu_seq_done(), as long as the distance
between the "running sequence" and the "target" is ULONG_MAX/2, it
returns correct results. OTHERWISE, it can return false results. So
for target value of 28 (in 5-bit world), only initial running values
from 12 would return FALSE. Before number 12, everything is TRUE. This
can cause both false-positives and false-negatives depending on the
input, however it is possible that are no users who use it causing
false-positives! So I guess it really depends on user.

False positives:
If the initial value is ULONG_MAX/2 away from the target, then
rcu_seq_done() can return TRUE when *no wraparound* happened.

False negatives:
The initial value of the snapshot was *within* the ULONG_MAX/2
distance from target. A full *wrap around then happened*, and we ended
where we were initially, so rcu_seq_done() should return TRUE but it
returns FALSE because it doesn't know about the wrap.

Now we move rcu_seq_done_exact. It has the exact same behavior except
that instead of ULONG_MAX/2, the above situations are shrunk to about
10 counts from the target. So if target is 28, then the initial
sequence should have been at least 18 to avoid false-positive, but
again it is possible and I certain see in the code that it cannot be
used this way.. (at least so far).. So all we are left with is the
false-negative band of ~2.5 GPs..

About "what are the consequences of failing to get this right".  I
believe false-positive is unacceptable unless it is maybe debug code -
that can break functionality in code, too short GPs and all that.
However false-negative is OK as long as the usecase can retry later
and can afford to wait. Did I get that much correct?

Thanks,

- Joel
