Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.90
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025246;
	b=zyKCHjYXA2sXV+wBoHBIIz8QhnpfaGfDh/LsNxPlHJzgqvbFWId3nAKjVhF29fTU05p7
	 StECWmgK2aSWFHSnUkBnf/eYm1jj7y897H2bvjw9Or5fh+C8NdLLX7nnfsQo08i8PSh7N
	 8hIofkTxe9q7yWKrATJGks02oh5iwR6li/hBBhzvnJ66UnnF/aGpl75OljzDG83hrIJLM
	 6kg2ZLiarcSG8SwcYZ9K8w2C7/QicdglZvjn/mNK/KlY5UDdxUe30KnyUkHr6lnxFLLBv
	 HPhIBjCnbSy3EiQfnfl8Im9bUDmpqFLa2mOpiBNMZdrxn0vBwIyev6ojsPjeIsyHQrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025246;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=Bq0dCo+hLaUPNO1PMcRPw8Cdoo0r1SoIO6xySRKjG64=;
	b=gmeKDKBus1vOYyiLT/O7GBWT8zhH1QCzzNgxiPFsaeV8kycU1HyunSmbo3Qk/htGKlTU
	 Kk+FAfW5zT5u20/kiZwuSqa2NNAS/exIX47bpz9g78R77ywfxmNLzxsZpFgrkLuZq0qnJ
	 Cym0U5+prwx3IV0TdcMHgiARL84I2dRErz0tOgT68W3l/32KKBeGrXCyL/JAd3YacEK8V
	 6QvUbOHl3zzu4xCCjlNGzmEUCTlNbK6Bu6yL4kfCrfGnN754BCv0WzOw3tU6FvibKUXtr
	 LKrZwci6qxHnTnlWNQSjOHXdHELVFjhgTklHuROLWLZoHcziceo4+p+Z1wu4iCCQv5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G8RMgrta;
	arc=none smtp.remote-ip=95.215.58.90
Received: from mta1.migadu.com (out-90.mta1.migadu.com [95.215.58.90])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C0606A32C
	for <rcu@vger.kernel.org>; Sat,  7 Nov 2026 04:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E30C0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G8RMgrta
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YCcxKrIcMOx//u0TM0K1pfTnYAP28oYPKkMZXvmjwuQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794025242; v=1; x=1794630042;
 b=G8RMgrtaxyEHR52ZM5HHM056f59sc0AbIq7/H+7xGHWPWy5N/UI2dFf12vCAWGrJx1D9znNj
 /fsHKScG1wcsHGfWE7xBJujMnhzRPK7+sOJD6XiH2YvsA7HQpea+OHpXO7aH4f+48bckNh/vpZb
 m2/syuIzpZrtDMlmI3aXgbcg=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 36ec68c139595b66;
	Sat, 07 Nov 2026 04:20:42 +0000
X-Mizu-Trace-ID: 36ec68c139595b66
X-Migadu-Flow: FLOW_OUT
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sat, 07 Nov 2026 04:20:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <2b4b213b4e9b27016982dfc517a5629f2ff5f3b8@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 0/5] rcu: Record callback enqueue stacks and add torture
 tests
To: paulmck@kernel.org, "Joel Fernandes" <joelagnelf@nvidia.com>, "Kunwu
 Chan" <kunwu.chan@gmail.com>
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, boqun@kernel.org, urezki@gmail.com,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 jiangshanlai@gmail.com, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
In-Reply-To: <dda59546-c03a-4c4c-9df3-a107bc629e2c@paulmck-laptop>
References: <20261106143913.3627722-1-kunwu.chan@gmail.com>
 <7883f32c-80b8-4bfa-a4e4-f1e04da647f3@nvidia.com>
 <dda59546-c03a-4c4c-9df3-a107bc629e2c@paulmck-laptop>

>=20
>=20On Fri, Nov 06, 2026 at 01:49:04PM -0500, Joel Fernandes wrote:
>=20
>=20>=20
>=20> On 11/6/2026 9:39 AM, Kunwu Chan wrote:
> >  This series adds KASAN auxiliary stack recording for RCU Tasks
> >  callbacks, rcutorture coverage for duplicate-callback detection,
> >  and KASAN aux-stack verification tests across RCU and SRCU flavors.
> >=20=20
>=20>  This series is based on [1]. For testing, I also applied Joel
> >  Fernandes' fix for debugobjects tracking of barrier callbacks
> >  [2], which is needed for the barrier tests.
> >=20=20
>=20>  The changes:
> >  - Record the enqueueing stack in call_rcu_tasks_generic().
> >  - Enable duplicate-callback testing for the "tasks" and
> >  "tasks-tracing" torture types.
> >  - Add a KASAN aux-stack verification test module with a Kconfig
> >  choice for each supported flavor.
> >  - Add one rcutorture scenario per flavor for the verification
> >  test.
> >=20=20
>=20>  Tested on x86_64:
> >=20=20
>=20>  - TASKS01, TASKS02, TASKS03, TRACE01, and TRACE02 completed
> >  3-minute runs successfully.
> >=20=20
>=20>  - With CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy and
> >  rcutorture.object_debug=3D1, duplicate-callback detection was
> >  triggered as expected for both torture types.
> >=20=20
>=20>  - TRACE01 was run for 1 minute with
> >  CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy and
> >  rcutorture.object_debug=3D1. The test detected both duplicate
> >  callback heads through the SRCU enqueue path:
> >  [ 0.405836] rcutorture: WARN: Duplicate call_tasks-tracing() test st=
arting.
> >  [ 0.405852] ODEBUG: activate active (active state 1) object: 0000000=
020df980d object type: rcu_head hint: 0x0
> >  [ 0.734724] rcu: __call_srcu(): Duplicate call_srcu() CB 0000000020d=
f980d->rcu_torture_leak_cb+0x0/0x10()
> >  [ 0.734780] ODEBUG: activate active (active state 1) object: 0000000=
06634e8c9 object type: rcu_head hint: 0x0
> >  [ 0.776688] rcu: __call_srcu(): Duplicate call_srcu() CB 00000000663=
4e8c9->rcu_torture_leak_cb+0x0/0x10()
> >  [ 0.779126] rcutorture: WARN: Duplicate call_tasks-tracing() test co=
mplete.
> >  [ 65.411342] tasks-tracing-torture:--- End of test: SUCCESS: ...
> >=20=20
>=20>  Both duplicate callback heads (the stack-allocated rh2 and
> >  the kmalloc-allocated rhp) were rejected and neither was invoked.
> >=20=20
>=20>  - With CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy,
> >  object_debug=3D1, and n_barrier_cbs=3D4, the TASKS01 barrier
> >  test completed 630/630 rounds without barrier errors.
> >  The only debugobjects warnings were the four intentional
> >  warnings from the duplicate-callback test at startup.
> >=20=20
>=20>  - All five aux-stack scenarios (TASKSKASAN01, TREEKASAN01,
> >  SRCUKASAN01, TINYKASAN01, and SRCUTINYKASAN01) produced the
> >  expected KASAN use-after-free reports. Each report's
> >  "Last potentially related work creation" entry showed the
> >  expected enqueue helper:
> >=20=20
>=20>  =3D=3D=3D=3D=3D TASKSKASAN01 =3D=3D=3D=3D=3D
> >  [ 1.244567] BUG: KASAN: slab-use-after-free in aux_test_init+0x8d/0x=
b0
> >  [ 1.244707] Last potentially related work creation:
> >  [ 1.244716] aux_test_call_rcu_tasks.constprop.0+0xc/0x20
> >=20=20
>=20>  =3D=3D=3D=3D=3D TREEKASAN01 =3D=3D=3D=3D=3D
> >  [ 0.670399] BUG: KASAN: slab-use-after-free in aux_test_init+0x8d/0x=
b0
> >  [ 0.670561] Last potentially related work creation:
> >  [ 0.670571] aux_test_call_rcu_tree.constprop.0+0xc/0x20
> >=20=20
>=20>  =3D=3D=3D=3D=3D SRCUKASAN01 =3D=3D=3D=3D=3D
> >  [ 0.658679] BUG: KASAN: slab-use-after-free in aux_test_init+0x94/0x=
c0
> >  [ 0.658919] Last potentially related work creation:
> >  [ 0.658932] aux_test_call_srcu.constprop.0+0x16/0x30
> >=20=20
>=20>  =3D=3D=3D=3D=3D TINYKASAN01 =3D=3D=3D=3D=3D
> >  [ 0.951503] BUG: KASAN: slab-use-after-free in aux_test_init+0x8d/0x=
b0
> >  [ 0.951641] Last potentially related work creation:
> >  [ 0.951650] aux_test_call_rcu_tiny.constprop.0+0xc/0x20
> >=20=20
>=20>  =3D=3D=3D=3D=3D SRCUTINYKASAN01 =3D=3D=3D=3D=3D
> >  [ 1.009005] BUG: KASAN: slab-use-after-free in aux_test_init+0x94/0x=
c0
> >  [ 1.009141] Last potentially related work creation:
> >  [ 1.009150] aux_test_call_srcu.constprop.0+0x16/0x30
> >=20=20
>=20>  I'm not feeling very excited about adding more configs just for KA=
SAN. That
> >  sounds like a maintenance burden. I believe Paul already has KASAN t=
esting in
> >  his scripts. Is it possible to activate this testing only when those=
 are enabled?
> >=20
>=20The usual way that I do KASAN testing is with the --kasan argument
> to kvm.sh. I use --kconfig and --bootargs to specify further testing,
> usually as another option in torture.sh. This causes the testing to
> be carried out as a matter of course.
>=20
>=20One good thing is that the Kconfig choice in patch 4/5 is automated s=
o
> that RCU_KASAN_AUX_TEST causes the right testing to happen depending on
> what is configured.
>=20
>=20Is it possible to drive this from --kasan and the rcutorture.object_d=
ebug
> kernel boot parameter or something similar? Or is there a better way
> to make the overall testing happen?

Hello, Kunwu

Perhaps we can simplify this testing, similar to object_debug testing.
double-free also should output stack (I did not actually test the
modifications below) which record by kasan_record_aux_stack():


diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 968343be4e0d..93b30bf90cc9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -120,6 +120,7 @@ torture_param(bool, nmi_calls, true, "Exercise ->call=
() from NMI on nmi_capable
 torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(bool, nwriters, 1, "Number of RCU writer threads (0 or 1)"=
);
 torture_param(int, object_debug, 0, "Enable debug-object double call_rcu=
() testing");
+torture_param(int, kasan_debug, 0, "Enable call_rcu() kasan testing");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplug=
s (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffie=
s), 0=3Ddisable");
 torture_param(bool, gpwrap_lag, true, "Enable grace-period wrap lag test=
ing");
@@ -4632,6 +4633,25 @@ static void rcu_test_debug_objects(void)
        kfree(rhp);
 }

+static void rcu_free_cb(struct rcu_head *rhp)
+{
+       kfree(rhp);
+}
+
+static void rcu_test_kasan(void)
+{
+       if (!IS_ENABLED(CONFIG_KASAN_GENERIC) ||
+                       !cur_ops->call || !cur_ops->cb_barrier)
+               return;
+
+       struct rcu_head *rhp =3D kmalloc_obj(*rhp);
+       if (rhp) {
+               cur_ops->call(rhp, rcu_free_cb);
+               cur_ops->cb_barrier();
+       }
+       kfree(rhp);
+}
+
 static void rcutorture_sync(void)
 {
        static unsigned long n;
@@ -5191,6 +5211,9 @@ rcu_torture_init(void)
        if (object_debug)
                rcu_test_debug_objects();

+       if (kasan_debug)
+               rcu_test_kasan();
+
        if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_=
unregister))
                cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);



Thanks
Zqiang


>=20
>=20 Thanx, Paul
>
