Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D418FC83
	for <rcu@vger.kernel.org>; Wed, 29 Jan 2025 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738150509; cv=none; b=tBVa/4Zn1qET6x/qc7pFkvusMMZ71RUpMCJXYzHfwzey916WnU9yZt9gCJsnhW7IXvx/I2kSNEc37ngq0W+kVvHldWEmcpE8+0s/5Fe09BV3nqhwQ9kBxUnzXiM6HiIRpcpgtpdRL1zjD9on0OWDyjd8lEMJ6RC69d/oJWWuSTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738150509; c=relaxed/simple;
	bh=cKQkfqKZpOzORs0LdFfqgXTm4zU7dGhPttbu1wvqG3M=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=DmIVqKD5dIe4voY/pLM1v6T6EnSFk90xLVG5dQlY9VvXT9Ix1kNg5oZk+gTnwX2NBr2pvrxeFGWAtFm4Z+6AWOUWHpfGKnLnuqWHJI+pbiu7vm32Cd5m7qpEDa5IrZtwYszML5JidmFfgefbxTTIpUJRpjSLWm/w+9xwyWWBzs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=AaS9Eo0x; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="AaS9Eo0x"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7be8f28172dso351238985a.3
        for <rcu@vger.kernel.org>; Wed, 29 Jan 2025 03:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1738150505; x=1738755305; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPzHPSmxTPIvOWCYCNwo8zgo2Gv6XYWZ8OH9ebSKkUA=;
        b=AaS9Eo0xT5fJi1FSHRXbpzShPoDFR/j6ZQZEimgRinn37tyuiuO/4heuxAD1nLO3Av
         Oii5oNtORJgM7CxxQENhJW4iJUujuVfxDOwCuId07yTJZlket7+gWNMhH2i0bRNpgRV1
         9ahP8UvyqKCK7g5U+lKoVeDnIUNuy16XQ/DNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738150505; x=1738755305;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPzHPSmxTPIvOWCYCNwo8zgo2Gv6XYWZ8OH9ebSKkUA=;
        b=uaxVKTu0Tfo+6rSMrlArkjxGgNsa73pvJZVb+/8Maz+slTOhThLFd3bqfqwRgNYE17
         5bP2Pru5sucacZwfE8XWTC1FQMQAMWXcv4GRNyhw/a/g1uPDwGegeX8P35Y97UhQgBB6
         It6dGGUdXc3dDD3tENy0ooHxScWlU1TGAWv3d1Fpdox6q/OuTwwoKXoJyQbsAuSBN88X
         ywM/Uei8AQaVRPlrMDc18cJa2/I5NBG0jHae55L1QReJzFQEDhqEbh4VVy1LBTnGUtUF
         9UNaIIR++zPubSdmt/qYuetkd3CBiCvnPMaGOHoorlEA2ma2jZowFWNe7rUFXcoi0jU6
         jvyA==
X-Forwarded-Encrypted: i=1; AJvYcCUsQwMYdeDuoyLjndXlC9N9/SOGZufa6hnrqB2+Gg6Hb3qzbkKkoS5LIBOKXFIFJGXeusk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx90PweqdtMnsMxVSgzen3CbuR4wTOMU67s0rrXeOYqAGQI3jsW
	WARlopYDGCc1RKU6oBBUD3YINGPf+PP/bcjY9f8xSuZ6tLBJU3G++kYJf5qsHDc=
X-Gm-Gg: ASbGncs0ZFCXo/0uXtpWk0Chx0wbFYN12q8eOI6W7h+U4FaSSbioybSl8XyKqEjhf8V
	xky66hJDPJjmXgcTph6VFuLITa8Rm71PFYa1JjCeihRXdjn/EklMp3WwamzQt8Ql+EchHwJoTiD
	QthgphF8D2wTy4M2La8EYrNQyG+NXax0qD9e4HOXP39jKPUMxI/TuO+VTUbjGS02sQJsB/Sr+Fx
	Gz86olx/n78ozd/iJKqw2z6Xzae5yR1rPFPrmeg5qlzbxpT/osSreVKL90DZs4wI0ZOrwv+7mHJ
	X0t+qjn2rqN0z7RVRclkVpDKxVPQ/5+yHBACjjUi2hlKk4k+WQFmcvgXsZnWyRDFLtObh+jWUr9
	pCQxo+w==
X-Google-Smtp-Source: AGHT+IG/zT/amntqEH0Pkg30kvkhsir/FKQwzAXQvJX9Jxy6zwPgOaEeTeg0BWfKfP/Ot/5mlNfuvQ==
X-Received: by 2002:a05:620a:178c:b0:7b7:142d:53b3 with SMTP id af79cd13be357-7bffcd9f123mr468739085a.55.1738150505476;
        Wed, 29 Jan 2025 03:35:05 -0800 (PST)
Received: from smtpclient.apple (c-73-251-172-144.hsd1.va.comcast.net. [73.251.172.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9aeedde6sm613544285a.88.2025.01.29.03.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 03:35:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu: Merge rcu_seq_done_exact() logic into rcu_seq_done()
Date: Wed, 29 Jan 2025 06:34:53 -0500
Message-Id: <15D1150A-9B7B-4EB7-91C6-2D881D6F48DA@joelfernandes.org>
References: <ecce7241-4238-4d86-8e4c-5080937129ce@paulmck-laptop>
Cc: linux-kernel@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu@vger.kernel.org
In-Reply-To: <ecce7241-4238-4d86-8e4c-5080937129ce@paulmck-laptop>
To: paulmck@kernel.org
X-Mailer: iPhone Mail (22B91)



> On Jan 28, 2025, at 9:21=E2=80=AFPM, Paul E. McKenney <paulmck@kernel.org>=
 wrote:
>=20
> =EF=BB=BFOn Tue, Jan 28, 2025 at 09:13:45PM -0500, Joel Fernandes wrote:
>>> On Tue, Jan 28, 2025 at 8:47=E2=80=AFPM Paul E. McKenney <paulmck@kernel=
.org> wrote:
>>>=20
>>> On Tue, Jan 28, 2025 at 08:38:57PM -0500, Joel Fernandes wrote:
>>>> On Tue, Jan 28, 2025 at 8:33=E2=80=AFPM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
>>>>>=20
>>>>> On Tue, Jan 28, 2025 at 08:22:48PM -0500, Joel Fernandes wrote:
>>>>>> On Mon, Jan 27, 2025 at 07:09:34PM -0500, Joel Fernandes wrote:
>>>>>>> On Mon, Jan 27, 2025 at 7:07=E2=80=AFPM Joel Fernandes (Google)
>>>>>>> <joel@joelfernandes.org> wrote:
>>>>>>>>=20
>>>>>>>> The rcu_seq_done() API has a large "false-negative" windows of size=

>>>>>>>> ULONG_MAX/2, where after wrap around, it is possible that it will t=
hink
>>>>>>>> that a GP has not completed if a wrap around happens and the delta i=
s
>>>>>>>> large.
>>>>>>>>=20
>>>>>>>> rcu_seq_done_exact() is more accurate avoiding this wrap around iss=
ue,
>>>>>>>> by making the window of false-negativity by only 3 GPs. Use this lo=
gic
>>>>>>>> for rcu_seq_done() which is a nice negative code delta and could
>>>>>>>> potentially avoid issues in the future where rcu_seq_done() was
>>>>>>>> reporting false-negatives for too long.
>>>>>>>>=20
>>>>>>>> rcutorture runs of all scenarios for 15 minutes passed. Code inspec=
tion
>>>>>>>> was done of all users to convince the change would work.
>>>>>>>>=20
>>>>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>>>>=20
>>>>>>> I am leaving a 60 minute overnight run of all scenarios on my person=
al
>>>>>>> server for further testing.
>>>>>>=20
>>>>>> The run passed, details below:
>>>>>>=20
>>>>>> --- Mon Jan 27 11:49:49 PM EST 2025 Test summary:
>>>>>> Results directory:
>>>>>> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 60=

>>>>>> RUDE01 ------- 14309 GPs (3.97472/s) [tasks-rude: g57884 f0x0 total-g=
ps=3D57880] n_max_cbs: 0
>>>>>> SRCU-L ------- 34121 GPs (9.47806/s) [srcu: g316564 f0x0 total-gps=3D=
79242] n_max_cbs: 150000
>>>>>> SRCU-N ------- 151316 GPs (42.0322/s) [srcu: g1840064 f0x0 total-gps=3D=
460117] n_max_cbs: 150000
>>>>>> SRCU-P ------- 35189 GPs (9.77472/s) [srcud: g320792 f0x0 total-gps=3D=
80299] n_max_cbs: 150000
>>>>>> SRCU-T ------- 389034 GPs (108.065/s) [srcu: g4142406 f0x0 total-gps=3D=
1035602] n_max_cbs: 50000
>>>>>> SRCU-U ------- 376267 GPs (104.519/s) [srcud: g3953834 f0x0 total-gps=
=3D988459] n_max_cbs: 50000
>>>>>> SRCU-V ------- 407633 GPs (113.231/s) [srcud: g4371704 f0x0 total-gps=
=3D1092927] n_max_cbs: 1000
>>>>>> TASKS01 ------- 11007 GPs (3.0575/s) [tasks: g57816 f0x0 total-gps=3D=
57808]
>>>>>> TASKS02 ------- 10539 GPs (2.9275/s) [tasks: g57936 f0x0 total-gps=3D=
57936]
>>>>>> TASKS03 ------- 10453 GPs (2.90361/s) [tasks: g57508 f0x0 total-gps=3D=
57508]
>>>>>> TINY01 ------- 511634 GPs (142.121/s) [rcu: g0 f0x0 total-gps=3D0] n_=
max_cbs: 57078
>>>>>> TINY02 ------- 541799 GPs (150.5/s) [rcu: g0 f0x0 total-gps=3D0] n_ma=
x_cbs: 2619
>>>>>> TRACE01 ------- 7299 GPs (2.0275/s) [tasks-tracing: g45844 f0x0 total=
-gps=3D45844] n_max_cbs: 50000
>>>>>> TRACE02 ------- 101265 GPs (28.1292/s) [tasks-tracing: g305464 f0x0 t=
otal-gps=3D305456] n_max_cbs: 100000
>>>>>> TREE01 ------- 97989 GPs (27.2192/s) [rcu: g479473 f0x0 total-gps=3D1=
20151]
>>>>>> TREE02 ------- 202908 GPs (56.3633/s) [rcu: g1459509 f0x0 total-gps=3D=
365162] n_max_cbs: 1139244
>>>>>> TREE03 ------- 168901 GPs (46.9169/s) [rcu: g1764445 f0x0 total-gps=3D=
441393] n_max_cbs: 1341765
>>>>>> TREE04 ------- 148876 GPs (41.3544/s) [rcu: g951744 f0x0 total-gps=3D=
238225] n_max_cbs: 236765
>>>>>> TREE05 ------- 220092 GPs (61.1367/s) [rcu: g1234385 f0x0 total-gps=3D=
308880] n_max_cbs: 82801
>>>>>> TREE07 ------- 34678 GPs (9.63278/s) [rcu: g207257 f0x0 total-gps=3D5=
2094]
>>>>>> TREE09 ------- 341706 GPs (94.9183/s) [rcu: g7693569 f0x0 total-gps=3D=
1923688] n_max_cbs: 1845334
>>>>>> --- Done at Mon Jan 27 11:49:55 PM EST 2025 (4:41:24) exitcode 0
>>>>>=20
>>>>> Very good!
>>>>>=20
>>>>> How would you go about analyzing whether this is really safe vs. getti=
ng
>>>>> just getting lucky and not having provoked an overflow?
>>>>=20
>>>> I would probably add a more specific test case stressing the API, or
>>>> even a unit test of just the API by passing a range of sequences.. I
>>>> should go ahead and do that but it sounds like you feel there is an
>>>> issue with the patch? :)
>>>=20
>>> 2^31 (let alone 2^63) is a very large number of grace periods, and
>>> so it is hard to test grace-period sequence-number wrap.
>>>=20
>>> Not impossible, though...
>>=20
>> We could test a decent number of candidate sequences to cover
>> different cases. Not ideal like bruteforcing, but...   Another idea is
>> to hardcode/assume ULONG_MAX as 16-bit in a unit test.
>=20
> Or put the various sequence numbers into an unsigned short or even
> an unsigned char.
>=20
> One set of use cases checks to see if a given CPU's ->gp_seq has fallen
> too far behind the current grace period, and sets a flag to alert
> that CPU.  Others rely on a false negative being functionally OK.
>=20
> Or so I believe.  ;-)

Thanks, I am itching to create a visualization of all eight bit combinations=
 and the output of both API, which will be a fun exercise however I=E2=80=99=
m missing something fundamental because as I mentioned in that 100 and 200 e=
xample, the API itself cannot distinguish between a wraparound and a legitim=
ate delay in comparison between start and a delayed end. I need to understan=
d this better and go through the code more. ;-/

Thanks,

- Joel


>=20
>                            Thanx, Paul
>=20
>> thanks,
>>=20
>> - Joel
>>=20
>>=20
>>=20
>>>>=20
>>>>>=20
>>>>>                                                        Thanx, Paul
>>>>>=20
>>>>>> thanks,
>>>>>>=20
>>>>>> - Joel
>>>>>>=20
>>>>>>=20
>>>>>>>=20
>>>>>>> thanks,
>>>>>>>=20
>>>>>>> - Joel
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>> ---
>>>>>>>> kernel/rcu/rcu.h  | 13 ++-----------
>>>>>>>> kernel/rcu/tree.c |  6 +++---
>>>>>>>> 2 files changed, 5 insertions(+), 14 deletions(-)
>>>>>>>>=20
>>>>>>>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>>>>>>>> index eed2951a4962..c2ca196907cb 100644
>>>>>>>> --- a/kernel/rcu/rcu.h
>>>>>>>> +++ b/kernel/rcu/rcu.h
>>>>>>>> @@ -146,19 +146,10 @@ static inline bool rcu_seq_started(unsigned l=
ong *sp, unsigned long s)
>>>>>>>>=20
>>>>>>>> /*
>>>>>>>>  * Given a snapshot from rcu_seq_snap(), determine whether or not a=

>>>>>>>> - * full update-side operation has occurred.
>>>>>>>> + * full update-side operation has occurred while also handling
>>>>>>>> + * wraparounds that exceed the (ULONG_MAX / 2) safety-factor/guard=
-band.
>>>>>>>>  */
>>>>>>>> static inline bool rcu_seq_done(unsigned long *sp, unsigned long s)=

>>>>>>>> -{
>>>>>>>> -       return ULONG_CMP_GE(READ_ONCE(*sp), s);
>>>>>>>> -}
>>>>>>>> -
>>>>>>>> -/*
>>>>>>>> - * Given a snapshot from rcu_seq_snap(), determine whether or not a=

>>>>>>>> - * full update-side operation has occurred, but do not allow the
>>>>>>>> - * (ULONG_MAX / 2) safety-factor/guard-band.
>>>>>>>> - */
>>>>>>>> -static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned l=
ong s)
>>>>>>>> {
>>>>>>>>        unsigned long cur_s =3D READ_ONCE(*sp);
>>>>>>>>=20
>>>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>>>>>> index b77ccc55557b..835600cec9ba 100644
>>>>>>>> --- a/kernel/rcu/tree.c
>>>>>>>> +++ b/kernel/rcu/tree.c
>>>>>>>> @@ -4300,7 +4300,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu_=
full);
>>>>>>>> bool poll_state_synchronize_rcu(unsigned long oldstate)
>>>>>>>> {
>>>>>>>>        if (oldstate =3D=3D RCU_GET_STATE_COMPLETED ||
>>>>>>>> -           rcu_seq_done_exact(&rcu_state.gp_seq_polled, oldstate))=
 {
>>>>>>>> +           rcu_seq_done(&rcu_state.gp_seq_polled, oldstate)) {
>>>>>>>>                smp_mb(); /* Ensure GP ends before subsequent access=
es. */
>>>>>>>>                return true;
>>>>>>>>        }
>>>>>>>> @@ -4347,9 +4347,9 @@ bool poll_state_synchronize_rcu_full(struct r=
cu_gp_oldstate *rgosp)
>>>>>>>>=20
>>>>>>>>        smp_mb(); // Order against root rcu_node structure grace-per=
iod cleanup.
>>>>>>>>        if (rgosp->rgos_norm =3D=3D RCU_GET_STATE_COMPLETED ||
>>>>>>>> -           rcu_seq_done_exact(&rnp->gp_seq, rgosp->rgos_norm) ||
>>>>>>>> +           rcu_seq_done(&rnp->gp_seq, rgosp->rgos_norm) ||
>>>>>>>>            rgosp->rgos_exp =3D=3D RCU_GET_STATE_COMPLETED ||
>>>>>>>> -           rcu_seq_done_exact(&rcu_state.expedited_sequence, rgosp=
->rgos_exp)) {
>>>>>>>> +           rcu_seq_done(&rcu_state.expedited_sequence, rgosp->rgos=
_exp)) {
>>>>>>>>                smp_mb(); /* Ensure GP ends before subsequent access=
es. */
>>>>>>>>                return true;
>>>>>>>>        }
>>>>>>>> --
>>>>>>>> 2.34.1
>>>>>>>>=20
