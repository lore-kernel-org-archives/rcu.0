Received: from mta1.migadu.com (out-143.mta1.migadu.com [95.215.58.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E54A090A
	for <rcu@vger.kernel.org>; Wed,  2 Sep 2026 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359402; cv=none; b=ijGeDzFkCC54uO/bgtxHbJg8UQYSiG9JyQ67QpCrSbwYDjAaDNLq3N4acoYpPLyVRUBNQFTwQIYtgWOhkY2kU9fuO5kKnjNyZzE8TCrQOKsgRYDNp03LMdxjfNmvnLg98trOhhZ01c1i7chDt88nt3AjdEE9Go5dB0ElfXs8AGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359402; c=relaxed/simple;
	bh=MWGj1vWp0d9WoQCmM9uXHZwG+syB54fRLWhxjTkWoxA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=twssGpnnph/1GdirWWaUI5iBnX41Brt67oxcSYuyQ97+L1m8wpSwqQqAUVNAK6MYmAX6qqCDuLOX5Sqqu4WhdvpV9iZF1xARsIM2wtPnfWIkjilOfBDfgT0RTu84kWYOSxed2MUcjMBP4XeRJKSJkXjVOFz+wRTzs2ZY8xfP96Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NIKYPzqc; arc=none smtp.client-ip=95.215.58.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NIKYPzqc"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MWGj1vWp0d9WoQCmM9uXHZwG+syB54fRLWhxjTkWoxA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788359397; v=1; x=1788964197;
 b=NIKYPzqcs9PquVsgqOq+uhbZPiDkdUtnoFFjPYCosd54wL6f/dI6+6ZQ0ZNHGvFJDBV5jU8H
 Te0dU6RQmQo+LYJi9TDUJsGZ7CU/Yff7E3V7/zgnjRv/KnOqZTC/O9C8L3tpWVyfKHOEe0DSf7o
 UjK4V5zKFXUb4gpCMr1Rpyh8=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8d9257da7697e91e;
	Wed, 02 Sep 2026 14:29:47 +0000
X-Mizu-Trace-ID: 8d9257da7697e91e
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Sep 2026 14:29:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <b686c4e5066aa11d7d868097b35e04db58190103@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] dlm: wait for outstanding SRCU callbacks to complete in
 exit paths
To: "Alexander Aring" <aahringo@redhat.com>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org
In-Reply-To: <b530646295a64f5e1cec5bfec5064f1fc79d3d9d@linux.dev>
References: <20260901091836.16906-1-qiang.zhang@linux.dev>
 <CAK-6q+jFXsZpWHrm0CSa8Tr+P3qHDmWVQA+9stXViyUf48CuvA@mail.gmail.com>
 <b530646295a64f5e1cec5bfec5064f1fc79d3d9d@linux.dev>

>=20
>=20>=20
>=20> Hi,
> >=20=20
>=20>  On Tue, Sep 1, 2026 at 5:19 AM Zqiang <qiang.zhang@linux.dev> wrot=
e:
> >=20=20
>=20>=20=20
>=20>  The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
> >  srcu protected connection and node hash tables and hand each
> >  element to call_srcu() for deferred freeing (connection_release()
> >  and midcomms_node_release()). call_srcu() is asynchronous: the
> >  callbacks are invoked only after an SRCU grace period, which may
> >  happen after the exit function has already returned.
> >=20=20
>=20>  These exit functions are reached from exit_dlm() on module unload.
> >  Once they return, module teardown continues and the module text
> >  may be unloaded while call_srcu() callbacks are still pending. When
> >  such a callback finally runs, it executes freed module code and
> >  touches the static SRCU domains that are being torn down, resulting
> >  in a use-after-free.

     I should rephrase it:

     Due to missed call to the srcu_barrier(), when invoke cleanup_srcu_s=
truct()
     and find there are still pending srcu callback, the WARN_ON() will t=
rigger.

     from kernel/rcu/srcutree.c in cleanup_srcu_struct():


                // Call srcu_barrier() before this cleanup_srcu_struct()
                // to avoid triggering this WARN_ON().
                if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
                            rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
                    rcu_cpu_beenfullyonline(sdp->cpu))
                        queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
                flush_work(&sdp->work);

Thanks
Zqiang

> >=20=20
>=20>  I thought again about this and in my opinion this is not possible =
as
> >  it is already being handled by DEFINE_STATIC_SRCU() with a cleanup
> >  handling when the module is unloaded.
> >=20
>=20When the moudle unload, the srcu_module_going() will call cleanup_src=
u_struct()
> and free_percpu(ssp->sda) to release resource. but we not call srcu_bar=
rier(),
> the srcu_barrier() should be called before cleanup_srcu_struct().
>=20
>=20>=20
>=20> I know that srcu subsystem does a lot of magic with modules init/ex=
it
> >  functionality to call init_srcu_struct() and cleanup_srcu_struct().
> >  See
> >=20=20
>=20>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/kernel/module/main.c?h=3Dv7.3-rc1#n2711
> >=20=20
>=20>  so this patch should be reverted. If they don't use a barrier ther=
e,
> >  the fix should be in the SRCU subsystem, but I believe the current
> >  SRCU implementation already handles this.
> >=20
>=20The srcu_barrier() need to be called, there are some description
> from Documentation/RCU/rcubarrier.rst:
>=20
>=20rcu_barrier()
> -------------
>=20
>=20This situation can be handled by the rcu_barrier() primitive. Rather
> than waiting for a grace period to elapse, rcu_barrier() waits for all
> outstanding RCU callbacks to complete. Please note that rcu_barrier()
> does **not** imply synchronize_rcu(), in particular, if there are no RC=
U
> callbacks queued anywhere, rcu_barrier() is within its rights to return
> immediately, without waiting for anything, let alone a grace period.
>=20
>=20Pseudo-code using rcu_barrier() is as follows:
>=20
>=20 1. Prevent any new RCU callbacks from being posted.
>  2. Execute rcu_barrier().
>  3. Allow the module to be unloaded.
>=20
>=20There is also an srcu_barrier() function for SRCU, and you of course
> must match the flavor of srcu_barrier() with that of call_srcu().
> If your module uses multiple srcu_struct structures, then it must also
> use multiple invocations of srcu_barrier() when unloading that module.
> For example, if it uses call_rcu(), call_srcu() on srcu_struct_1, and
> call_srcu() on srcu_struct_2, then the following three lines of code
> will be required when unloading::
>=20
>=20 1 rcu_barrier();
>  2 srcu_barrier(&srcu_struct_1);
>  3 srcu_barrier(&srcu_struct_2);
> ....
>=20
>=20Thanks
> Zqiang
>=20
>=20>=20
>=20> - Alex
> >=20=20
>=20>=20=20
>=20>  Add an srcu_barrier() after the call_srcu() loop in each exit func=
tion
> >  to wait for all outstanding callbacks of the respective SRCU domain =
to
> >  complete before returning. In dlm_midcomms_exit() the barrier is iss=
ued
> >  before dlm_lowcomms_exit() so that node callbacks are drained prior =
to
> >  tearing down the lower layer.
> >=20=20
>=20>  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >  ---
> >  fs/dlm/lowcomms.c | 1 +
> >  fs/dlm/midcomms.c | 1 +
> >  2 files changed, 2 insertions(+)
> >=20=20
>=20>  diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> >  index 2aff1c7c17de..ea8353c4638d 100644
> >  --- a/fs/dlm/lowcomms.c
> >  +++ b/fs/dlm/lowcomms.c
> >  @@ -1984,4 +1984,5 @@ void dlm_lowcomms_exit(void)
> >  }
> >  }
> >  srcu_read_unlock(&connections_srcu, idx);
> >  + srcu_barrier(&connections_srcu);
> >  }
> >  diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
> >  index 8964164600d2..045431524494 100644
> >  --- a/fs/dlm/midcomms.c
> >  +++ b/fs/dlm/midcomms.c
> >  @@ -1178,6 +1178,7 @@ void dlm_midcomms_exit(void)
> >  }
> >  }
> >  srcu_read_unlock(&nodes_srcu, idx);
> >  + srcu_barrier(&nodes_srcu);
> >=20=20
>=20>  dlm_lowcomms_exit();
> >  }
> >  --
> >  2.17.1
> >
>
