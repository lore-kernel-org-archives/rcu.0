Received: from mta0.migadu.com (out-34.mta0.migadu.com [91.218.175.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B5F44471C
	for <rcu@vger.kernel.org>; Thu, 27 Aug 2026 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829208; cv=none; b=DfpsdRU03xtPQaQbtCuhxBSfR1K6NFFt1xcIXPD1aD3eHrbZETooQeSvTQ1w8Eaqfw6YzW5Wfu0434525J9oirhuoFDQwittsL19BvEyDAOFbwSpbxkNaPhJm07MPYCOOEoDz8cDoGTMa+kJ52saq2T1WgBmBAFb8kHMJTGpNh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829208; c=relaxed/simple;
	bh=VIBFLSp6vCSrLBB8roQJG9kGbGDTxq434AI4pWWKGCs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ESMRoRpGwazKoHdfF1HWolynW11/oRM9Gw+4CTbWQs4m84XY5+9vMJ2gRkc8S53+TLhphhwnZahHrZ2rToAoXpVhGipJj5hrMZ1oQvJD2iv0Wz4zBCknB2JQdd9SF1PNqEKxc6l9JVQPtbnQfD6r58bk4ZbJfzTf6poO/dP0w6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LVSplgYM; arc=none smtp.client-ip=91.218.175.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LVSplgYM"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VIBFLSp6vCSrLBB8roQJG9kGbGDTxq434AI4pWWKGCs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787829200; v=1; x=1788434000;
 b=LVSplgYMvMFKVy72UpOCVyhuL4hGAjmvXxAnbJxiX+hvQS2pWZUcP9THkQH9+TgGX+UfTkix
 7bUdOwNPFNf62eBP0ObqSV3hwOJ23JdS9G+5RNHDO0VlhODo5xgSXoJNBQSOWHfmQZzPzguXnTR
 /qHyer9mf1+XkGnDSU1XPNng=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1bd3b72e5361c2bd;
	Thu, 27 Aug 2026 11:13:20 +0000
X-Mizu-Trace-ID: 1bd3b72e5361c2bd
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 11:13:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <e6350377085ddd85d6ef00d8e9a67bd50c762d3c@linux.dev>
TLS-Required: No
Subject: Re: [BUG] srcu: false-positive WARN in cleanup_srcu_struct() after
 78a38cbf6f20
To: "Sunho Park" <shpark061104@gmail.com>, rcu@vger.kernel.org
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org,
 syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
In-Reply-To: <f85c60a0-81d7-41a4-9926-f69cf10222d0@gmail.com>
References: <20260824105625.3725157-1-shpark061104@gmail.com>
 <494f3e0cdb3692bf13690f4cddd3b40098b51627@linux.dev>
 <24c0edd6-3cdc-4536-ac78-394bf785aad4@gmail.com>
 <0e74e6799bf042293fd1e34e2f242c56786c3de4@linux.dev>
 <9e216978-d884-4d56-b39f-d134f78a4999@gmail.com>
 <eb2132ad05cd3804a8f2a170de441d79afa793e9@linux.dev>
 <f85c60a0-81d7-41a4-9926-f69cf10222d0@gmail.com>

>=20
>=20On 8/27/26 08:53, Zqiang wrote:
>=20
>=20>=20
>=20> Based on your description below, the 5.srcu_barrier() did not inter=
cept the callback of 4.call_srcu(),
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
> >=20
>=20Before 5. srcu_barrier() call, the 4. call_srcu() is finished and the=
 callback was enqueued, and srcu_barrier() did intercept it by appending =
barrier cb after it. They can't be called concurrently because when call_=
srcu() is called inside kvm_io_bus_register_dev(), the kvm reference coun=
t is nonzero and kvm_destroy_vm() which calls srcu_barrier() could not be=
 started.
>

Which tree is your test based on? (rcu tree or linux-next tree)

The step 4 call_srcu() is finished and then the step5 call srcu_barrier()=
, it failed to intercept it?
(theoretically, this shouldn't happen)

=20
>=20In my debugging, all five __free_bus() callbacks enqueued by kvm_io_b=
us_register_dev() were invoked before the barrier cb, and only then the b=
arrier cb is called and srcu_barrier() returns. So all the real callbacks=
 were executed and practically there were no callbacks left to execute wh=
en srcu_barrier() returns, but a stale n_cbs > 0 is left because srcu_inv=
oke_callbacks()'s invoking loop has not finished.
>=20
>=20KVM logic correctly called srcu_barrier() and cleanup_srcu_struct() w=
ithout calling call_srcu() in between. In my opinion, the root causes are=
 as follows:
>=20
>=201) for timer_delete_sync(): the srcu_gp_end() which ended the last gr=
ace period (from 4. ) arms sdp->delay_work to expire at jiffies + 1 even =
though the invoke work (queued in 3. ) is already queued, and cleanup_src=
u_struct() runs before that one-jiffy timer expires, so timer_delete_sync=
() cancels that pending timer and returns true.
>=20
>=202) for n_cbs: srcu_invoke_callbacks() calls rcu_segcblist_add_len(-le=
n) only at the end of the work item, after the barrier callback has been =
invoked and srcu_barrier() has already returned, so cleanup_srcu_struct()=
 observes a stale n_cbs > 0 while the cblist is physically empty.

because you say the 5.srcu_barrier() can not intercept setp4 call_srcu() =
enqueue callback func,=20
that=20means that the step4 srcu callback shuold not be run, the cblist a=
lso not empty.

Thanks
Zqiang=20

>=20
> Thanks
> Sunho Park
>
