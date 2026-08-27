Received: from mta1.migadu.com (out-63.mta1.migadu.com [95.215.58.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8D25B08B
	for <rcu@vger.kernel.org>; Thu, 27 Aug 2026 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834411; cv=none; b=S7Icb3FcV5JZ5L6g2ABaZ1efrmd46+BJiKsk0HuEMId2wVTMZOEW2j1ZEDCleDLUfFYzJQso62ZzGoZ8pYQ9VflM5bWgcWLND00oFU0ghwHe5D7YiUjWYXNfNIOj0sPS84cVNdVD4GD4MtOgiaAjAfVjSBd2CMk2CjHLYR8rnKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834411; c=relaxed/simple;
	bh=DhfxAz7/8PH1H8xb58KTOK9hBAen2mqjwlQZdSBXKrc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ugcJ1s2tD3QH8BBOQ4P1jF83dqeo2fuzNzWU7fFSfMCKh4+6rXTIIdxjkpb0fHtWf6yFEfYerG1HSATQ2fqHG9ff/e3hcVIW9FoH/MMlXuWC2Fc4NyQ4anfIaMEZwgC92TiKkICgsPBVrLiDDv7zAdfiplUcHVU2XZm9MAiOW9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h6z5bwh7; arc=none smtp.client-ip=95.215.58.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h6z5bwh7"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DhfxAz7/8PH1H8xb58KTOK9hBAen2mqjwlQZdSBXKrc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787834406; v=1; x=1788439206;
 b=h6z5bwh7bTzdLm4772bnu4+LP2nq2iOAr6g+AQ2nfgr08WEJhRhkFMM1BeUn5IOnrXeGsAOm
 a00tFbo2XPTYeHj0f8+s8VEviwITRQHuXmJblL9akeJuS34rYQVhNvj1ZaBn6n1OYS/oAE5S0Xy
 gG4Zr/UZnLfu1kpTu5nJq92g=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 50b022db7692f65a;
	Thu, 27 Aug 2026 12:40:06 +0000
X-Mizu-Trace-ID: 50b022db7692f65a
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 12:40:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <d036078f31cd8f0fdf0b9185ce8cadef803cc375@linux.dev>
TLS-Required: No
Subject: Re: [BUG] srcu: false-positive WARN in cleanup_srcu_struct() after
 78a38cbf6f20
To: "Sunho Park" <shpark061104@gmail.com>, rcu@vger.kernel.org
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org,
 syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
In-Reply-To: <698a4d8b6c559f9049ee6fa6b0bc99d45a3d7e44@linux.dev>
References: <20260824105625.3725157-1-shpark061104@gmail.com>
 <494f3e0cdb3692bf13690f4cddd3b40098b51627@linux.dev>
 <24c0edd6-3cdc-4536-ac78-394bf785aad4@gmail.com>
 <0e74e6799bf042293fd1e34e2f242c56786c3de4@linux.dev>
 <9e216978-d884-4d56-b39f-d134f78a4999@gmail.com>
 <eb2132ad05cd3804a8f2a170de441d79afa793e9@linux.dev>
 <f85c60a0-81d7-41a4-9926-f69cf10222d0@gmail.com>
 <e6350377085ddd85d6ef00d8e9a67bd50c762d3c@linux.dev>
 <698a4d8b6c559f9049ee6fa6b0bc99d45a3d7e44@linux.dev>

>=20
>=20>=20
>=20> On 8/27/26 08:53, Zqiang wrote:
> >=20=20
>=20>=20=20
>=20>  Based on your description below, the 5.srcu_barrier() did not inte=
rcept the callback of 4.call_srcu(),
> >  this means that 4.call_srcu() and 5.srcu_barrier() concurrent calls,=
 or calls after 5.srcu_barrier().
> >  The combination of srcu_barrier() and cleanup_srcu_struct() typicall=
y occurs on the module exit path.
> >  srcu_barrier() ensures that all previously inserted callbacks comple=
te=EF=BC=8Cso therefore, theoretically,
> >  there shouldn't be any callbacks left to execute after we finish exe=
cuting srcu_barrier().
> >  and of course, there are also shouldn't be any ongoing or newly star=
ted SRCU grace period and the
> >  WARN_ON() in cleanup_srcu_struct() is designed to detect it.
> >  If when the cleanup_srcu_struct() detects an incomplete SRCU grace p=
eriod or any srcu callbacks
> >  that have not yet been executed, this is a risk that needs to be rep=
orted, even if the
> >  cleanup_srcu_struct() can intercept it internally.
> >  > Therefore, we should investigate this issue to ensure that 5.srcu_=
barrier() can intercept the step 4 callback.
> >  Thanks
> >  Zqiang
> >=20=20
>=20>  Before 5. srcu_barrier() call, the 4. call_srcu() is finished and =
the callback was enqueued, and srcu_barrier() did intercept it by appendi=
ng barrier cb after it. They can't be called concurrently because when ca=
ll_srcu() is called inside kvm_io_bus_register_dev(), the kvm reference c=
ount is nonzero and kvm_destroy_vm() which calls srcu_barrier() could not=
 be started.
> >=20=20
>=20>  Which tree is your test based on? (rcu tree or linux-next tree)
> >=20=20
>=20>  The step 4 call_srcu() is finished and then the step5 call srcu_ba=
rrier(), it failed to intercept it?
> >  (theoretically, this shouldn't happen)
> >=20
>=20Sorry, here I missed.
>=20
>=20>=20
>=20> In my debugging, all five __free_bus() callbacks enqueued by kvm_io=
_bus_register_dev() were invoked before the barrier cb, and only then the=
 barrier cb is called and srcu_barrier() returns. So all the real callbac=
ks were executed and practically there were no callbacks left to execute =
when srcu_barrier() returns, but a stale n_cbs > 0 is left because srcu_i=
nvoke_callbacks()'s invoking loop has not finished.
> >=20=20
>=20>  KVM logic correctly called srcu_barrier() and cleanup_srcu_struct(=
) without calling call_srcu() in between. In my opinion, the root causes =
are as follows:
> >=20=20
>=20>  1) for timer_delete_sync(): the srcu_gp_end() which ended the last=
 grace period (from 4. ) arms sdp->delay_work to expire at jiffies + 1 ev=
en though the invoke work (queued in 3. ) is already queued, and cleanup_=
srcu_struct() runs before that one-jiffy timer expires, so timer_delete_s=
ync() cancels that pending timer and returns true.
> >=20
>=20The step5 srcu_barrier() has been intercept the srcu callback which b=
y step4 call_srcu() insert,
> so at here, the srcu_barrier should not be return, and the step4 srcu c=
allback should not be run.
> the cleanup_srcu_struct() also should not be called.
>=20
>=20Thanks
> Zqiang
>=20
>=20>=20
>=20> 2) for n_cbs: srcu_invoke_callbacks() calls rcu_segcblist_add_len(-=
len) only at the end of the work item, after the barrier callback has bee=
n invoked and srcu_barrier() has already returned, so cleanup_srcu_struct=
() observes a stale n_cbs > 0 while the cblist is physically empty.



Now, I am trying to rephrase your problem in the following way:

1- the step1 call_srcu() trigger SRCU grace period has been end and queue=
 sdp->work.
2- the step4 queue srcu callback has been intercepted by step5 srcu_barri=
er()
   and start a new SRCU grace period.
3- this new SRCU grace period end, and invoke rcu_seq_end(&sup->srcu_gp_s=
eq), queue a timer.
4- the sdp->work begin run, and call srcu_segcblist_advance() with curren=
t sup->srcu_gp_seq.
   so the step4's srcu callback and step5's barrier calback both to be ru=
n.
   all callback finished, but the len not yet update.
5- the srcu_barrier() return, begin call srcu_clean_up(), and then the sr=
cu_clean_up
   find the a timer is still pending and the cb_len also not be zero, tri=
gger WARN_ON()

right?

Thanks
Zqiang
=20=20=20





>=20>=20=20
>=20>  because you say the 5.srcu_barrier() can not intercept setp4 call_=
srcu() enqueue callback func,=20
>=20>  that means that the step4 srcu callback shuold not be run, the cbl=
ist also not empty.
> >=20=20
>=20>  Thanks
> >  Zqiang=20
>=20>=20=20
>=20>=20=20
>=20>  Thanks
> >  Sunho Park
> >
>
