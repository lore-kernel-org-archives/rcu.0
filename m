Received: from mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B183E4A2605
	for <rcu@vger.kernel.org>; Wed,  2 Sep 2026 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358555; cv=none; b=INvWTCU18mK/0CCm8o828FMUAeRXbG7goMbEH18vDDWUxJkASbcsGlg01mL8NSH86OADbXZzXvNyTIXSGOY+Ju4pT4LlXxj9czICtt1SEgqm+iUU+PlOCdvttb3iy3Yh3Jq9q4YEXDY851fTRcutsHapFnRr9fjMwbztCqhpMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358555; c=relaxed/simple;
	bh=qUI1BXj/T7Olo0+sRw14nkhwV27mKpXf5s4YiHaq1sc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=WeuFgY3EeK1C35MAP1Tlsgq02J+zqE+Qy29NnsuSqnf0RfIwsRcoQSCPyrIHxzY2nBit61sgGbTtM/+ZcRzsbBsrGUFBTWQN8N8X/1F7Wxg1UEUf+Z0JSrB8N+peu/bosuNnpxyCS0dbcsvONyWNeJ88qZPRiCbBUHmtMvA4EDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PsxsnBHg; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PsxsnBHg"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qUI1BXj/T7Olo0+sRw14nkhwV27mKpXf5s4YiHaq1sc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788358551; v=1; x=1788963351;
 b=PsxsnBHgvyDIPYbEInGtPO5fZfaV22fxMKkYMRTdyN35o8/b3BqUHGLcPnXu4v3GyjDND3aA
 IWAw5Kml9J6YdyKBdj9pmt6ce3DgpvKTJwnreqnsPX2+quXvXRBE54rgrJ3IOyCBtttuCmMazp0
 q8mKobM/hfu5qmbT3jesQA1g=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 024c0cd5b61d1bef;
	Wed, 02 Sep 2026 14:15:51 +0000
X-Mizu-Trace-ID: 024c0cd5b61d1bef
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Sep 2026 14:15:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <b530646295a64f5e1cec5bfec5064f1fc79d3d9d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] dlm: wait for outstanding SRCU callbacks to complete in
 exit paths
To: "Alexander Aring" <aahringo@redhat.com>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org
In-Reply-To: <CAK-6q+jFXsZpWHrm0CSa8Tr+P3qHDmWVQA+9stXViyUf48CuvA@mail.gmail.com>
References: <20260901091836.16906-1-qiang.zhang@linux.dev>
 <CAK-6q+jFXsZpWHrm0CSa8Tr+P3qHDmWVQA+9stXViyUf48CuvA@mail.gmail.com>

>=20
>=20Hi,
>=20
>=20On Tue, Sep 1, 2026 at 5:19 AM Zqiang <qiang.zhang@linux.dev> wrote:
>=20
>=20>=20
>=20> The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
> >  srcu protected connection and node hash tables and hand each
> >  element to call_srcu() for deferred freeing (connection_release()
> >  and midcomms_node_release()). call_srcu() is asynchronous: the
> >  callbacks are invoked only after an SRCU grace period, which may
> >  happen after the exit function has already returned.
> >=20
>=20>  These exit functions are reached from exit_dlm() on module unload.
> >  Once they return, module teardown continues and the module text
> >  may be unloaded while call_srcu() callbacks are still pending. When
> >  such a callback finally runs, it executes freed module code and
> >  touches the static SRCU domains that are being torn down, resulting
> >  in a use-after-free.
> >=20
>=20I thought again about this and in my opinion this is not possible as
> it is already being handled by DEFINE_STATIC_SRCU() with a cleanup
> handling when the module is unloaded.

When the moudle unload, the srcu_module_going() will call cleanup_srcu_st=
ruct()
and free_percpu(ssp->sda) to release resource. but we not call srcu_barri=
er(),
the srcu_barrier() should be called before cleanup_srcu_struct().


> I know that srcu subsystem does a lot of magic with modules init/exit
> functionality to call init_srcu_struct() and cleanup_srcu_struct().
> See
>=20
>=20https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/kernel/module/main.c?h=3Dv7.3-rc1#n2711
>=20
>=20so this patch should be reverted. If they don't use a barrier there,
> the fix should be in the SRCU subsystem, but I believe the current
> SRCU implementation already handles this.

The srcu_barrier() need to be called, there are some description
from Documentation/RCU/rcubarrier.rst:

rcu_barrier()
-------------

This situation can be handled by the rcu_barrier() primitive.  Rather
than waiting for a grace period to elapse, rcu_barrier() waits for all
outstanding RCU callbacks to complete.  Please note that rcu_barrier()
does **not** imply synchronize_rcu(), in particular, if there are no RCU
callbacks queued anywhere, rcu_barrier() is within its rights to return
immediately, without waiting for anything, let alone a grace period.

Pseudo-code using rcu_barrier() is as follows:

   1. Prevent any new RCU callbacks from being posted.
   2. Execute rcu_barrier().
   3. Allow the module to be unloaded.

There is also an srcu_barrier() function for SRCU, and you of course
must match the flavor of srcu_barrier() with that of call_srcu().
If your module uses multiple srcu_struct structures, then it must also
use multiple invocations of srcu_barrier() when unloading that module.
For example, if it uses call_rcu(), call_srcu() on srcu_struct_1, and
call_srcu() on srcu_struct_2, then the following three lines of code
will be required when unloading::

  1  rcu_barrier();
  2  srcu_barrier(&srcu_struct_1);
  3  srcu_barrier(&srcu_struct_2);
....

Thanks
Zqiang

>=20
>=20- Alex
>=20
>=20>=20
>=20> Add an srcu_barrier() after the call_srcu() loop in each exit funct=
ion
> >  to wait for all outstanding callbacks of the respective SRCU domain =
to
> >  complete before returning. In dlm_midcomms_exit() the barrier is iss=
ued
> >  before dlm_lowcomms_exit() so that node callbacks are drained prior =
to
> >  tearing down the lower layer.
> >=20
>=20>  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >  ---
> >  fs/dlm/lowcomms.c | 1 +
> >  fs/dlm/midcomms.c | 1 +
> >  2 files changed, 2 insertions(+)
> >=20
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
> >=20
>=20>  dlm_lowcomms_exit();
> >  }
> >  --
> >  2.17.1
> >
>
