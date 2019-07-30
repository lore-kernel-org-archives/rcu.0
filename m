Return-Path: <SRS0=Tqm2=V3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C8FC32750
	for <rcu@archiver.kernel.org>; Tue, 30 Jul 2019 23:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AA420679
	for <rcu@archiver.kernel.org>; Tue, 30 Jul 2019 23:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564527673;
	bh=SrNMkjGLqLAaMemXiMmAVwFlf76Gua+uX5QZ3yaAhnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fOvNYE6YZZHzZVg0Stodii8sLgN0NWdnLmaz0omBV99PnPK1LBntp+eUE00OMYs0M
	 c5pOsc5Dhuk9aITcdkPGSVruvT3oNp3uB/JzihJ/+1kP5qp2SH7lzfGGjLg00tC067
	 laQkS+VqBamAm9kUaCAo3WrVtxaDfesJIQoc53uE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfG3XBM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 Jul 2019 19:01:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfG3XBL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 30 Jul 2019 19:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZgdGFJcXoYn5WYrTduV9PjafjQQxP0aZfPbyUAeZBfY=; b=MN7Wm1o/rxpdFJ4YR5yULh1zZ
        S5sn6uBZNoLh658nnl//0FQ7W1vOHcXHx+nnaDVFDvS56pB/LsfwOXzHDX+YG9ZxGDKLQlNakeS3A
        yC5vXpZhI0MAZTQS9kHUsGfKNoMLBVVeoJwYPGCK6+KlFu3aw88LbGxvVR2t/92DzTVJ8OiKRLfoZ
        xlL2kX25mfTfaTQ3ftG/2bkQDaXeqAwe6XQy56HN1a516SLefZAbx6gb2pSRRvG4As1cWK/WNPQVO
        GmkFtayRtMtynT36QXHntNUPaWNyTXzt+/X5Ef25VktOrvXl6fYQgpaNpuW0CblSUqlU8yPOOEpNv
        nJkzceW4Q==;
Received: from [177.157.101.143] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsb78-0008Nl-8B; Tue, 30 Jul 2019 23:01:03 +0000
Date:   Tue, 30 Jul 2019 20:00:57 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 25/26] docs: rcu: convert some articles from html to
 ReST
Message-ID: <20190730200057.6ddcc2ce@coco.lan>
In-Reply-To: <20190730222130.GD254050@google.com>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
        <8444797277eea7be474f40625bb190775a9cee33.1564145354.git.mchehab+samsung@kernel.org>
        <20190730212250.GJ14271@linux.ibm.com>
        <20190730215007.GA254050@google.com>
        <20190730190028.740c131e@coco.lan>
        <20190730222130.GD254050@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Em Tue, 30 Jul 2019 18:21:30 -0400
Joel Fernandes <joel@joelfernandes.org> escreveu:

> On Tue, Jul 30, 2019 at 07:00:28PM -0300, Mauro Carvalho Chehab wrote:
> > Em Tue, 30 Jul 2019 17:50:07 -0400
> > Joel Fernandes <joel@joelfernandes.org> escreveu:
> >  =20
> > > On Tue, Jul 30, 2019 at 02:22:50PM -0700, Paul E. McKenney wrote: =20
> > > > On Fri, Jul 26, 2019 at 09:51:35AM -0300, Mauro Carvalho Chehab wro=
te:   =20
> > > > > There are 4 RCU articles that are written on html format.
> > > > >=20
> > > > > The way they are, they can't be part of the Linux Kernel
> > > > > documentation body nor share the styles and pdf output.
> > > > >=20
> > > > > So, convert them to ReST format.
> > > > >=20
> > > > > This way, make htmldocs and make pdfdocs will produce a
> > > > > documentation output that will be like the original ones, but
> > > > > will be part of the Linux Kernel documentation body.
> > > > >=20
> > > > > Part of the conversion was done with the help of pandoc, but
> > > > > the result had some broken things that had to be manually
> > > > > fixed.
> > > > >=20
> > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>=
   =20
> > > >=20
> > > > I am having some trouble applying these, at least in part due to UT=
F-8
> > > > sequences, for example double left quotation mark.  These end up be=
ing
> > > > "=3DE2=3D80=3D9C", with a few space characters turned into "=3D20".
> > > >=20
> > > > Any advice on how to apply these?  Should I just pull commits from
> > > > somewhere?   =20
> > >=20
> > > I was able to successfully apply and build this particular patch. I t=
hink
> > > this is the only one in the series that applies to RCU.
> > >=20
> > > Sadly, I can't find the patch in any of the public archives, but I co=
uld
> > > perhaps email it to you as an .mbox attach which 'git am' should be a=
ble to
> > > apply.
> > >=20
> > > Mauro did say he was going to add some more details to changelog, or =
it could
> > > be added when it is applied:
> > > https://lore.kernel.org/rcu/20190726154550.5eeae294@coco.lan/ =20
> >=20
> > Yeah, I'm also planning to address at least some of the issues you
> > pointed, in order to improve the html output, but got sidetracked by so=
mething=20
> > else and didn't find any time yet to finish. I'm adding some CI automat=
ion for
> > the media subsystem in order to help us dealing with the huge amount of=
 patches
> > we receive there.
> >=20
> > Feel free to add those details to the changelog. I may find some spare =
time=20
> > this week or the next one for the improvements you suggested, but those=
=20
> > could be sent on followup patches, once done. =20
>=20
> Ok, I will re-send this RCU patch with the changes, leave this one to me.
>=20
> The other memory model one, needs a lot more work so we can keep that asi=
de
> for now till someone has the time.

Yeah, feel free to do what fits best with regards to this one.

If you prefer to merge it instead, I'm enclosing the last version of it,
with that quick hack I just wrote, plus the change of the toctree for
it to produce the 2-level index.

Thanks,
Mauro

[PATCH] tools: memory-model: add it to the Documentation body

The books at tools/memory-model/Documentation are very well
formatted. Congrats to the ones that wrote them!

The manual conversion to ReST is really trivial:

	- Add document titles;
	- change the bullets on some lists;
	- mark code blocks.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

diff --git a/Documentation/core-api/refcount-vs-atomic.rst b/Documentation/=
core-api/refcount-vs-atomic.rst
index 976e85adffe8..7e6500a6fa76 100644
--- a/Documentation/core-api/refcount-vs-atomic.rst
+++ b/Documentation/core-api/refcount-vs-atomic.rst
@@ -17,7 +17,7 @@ in order to help maintainers validate their code against =
the change in
 these memory ordering guarantees.
=20
 The terms used through this document try to follow the formal LKMM defined=
 in
-tools/memory-model/Documentation/explanation.txt.
+tools/memory-model/Documentation/explanation.rst.
=20
 memory-barriers.txt and atomic_t.txt provide more background to the
 memory ordering in general and for atomic operations specifically.
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 2df5a3da563c..5123770ba77e 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -36,6 +36,7 @@ trying to get it to work optimally on a given system.
=20
    admin-guide/index
    kbuild/index
+   tools/index
=20
 Firmware-related documentation
 ------------------------------
diff --git a/Documentation/tools/index.rst b/Documentation/tools/index.rst
new file mode 100644
index 000000000000..f540d9cc75a1
--- /dev/null
+++ b/Documentation/tools/index.rst
@@ -0,0 +1,17 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Linux Tools
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. toctree::
+   :maxdepth: 2
+
+   memory-model/index
+
+.. only::  subproject and html
+
+   Indices
+   =3D=3D=3D=3D=3D=3D=3D
+
+   * :ref:`genindex`
diff --git a/Documentation/tools/memory-model b/Documentation/tools/memory-=
model
new file mode 120000
index 000000000000..020ed38ce302
--- /dev/null
+++ b/Documentation/tools/memory-model
@@ -0,0 +1 @@
+../../tools/memory-model/Documentation/
\ No newline at end of file
diff --git a/tools/memory-model/Documentation/cheatsheet.rst b/tools/memory=
-model/Documentation/cheatsheet.rst
new file mode 100644
index 000000000000..35f8749b8a53
--- /dev/null
+++ b/tools/memory-model/Documentation/cheatsheet.rst
@@ -0,0 +1,36 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Cheat Sheet
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+::
+
+				    Prior Operation     Subsequent Operation
+				    ---------------  ---------------------------
+				 C  Self  R  W  RMW  Self  R  W  DR  DW  RMW  SV
+				--  ----  -  -  ---  ----  -  -  --  --  ---  --
+
+  Store, e.g., WRITE_ONCE()            Y                                  =
     Y
+  Load, e.g., READ_ONCE()              Y                          Y   Y   =
     Y
+  Unsuccessful RMW operation           Y                          Y   Y   =
     Y
+  rcu_dereference()                    Y                          Y   Y   =
     Y
+  Successful *_acquire()               R                   Y  Y   Y   Y   =
 Y   Y
+  Successful *_release()         C        Y  Y    Y     W                 =
     Y
+  smp_rmb()                               Y       R        Y      Y       =
 R
+  smp_wmb()                                  Y    W           Y       Y   =
 W
+  smp_mb() & synchronize_rcu()  CP        Y  Y    Y        Y  Y   Y   Y   =
 Y
+  Successful full non-void RMW  CP     Y  Y  Y    Y     Y  Y  Y   Y   Y   =
 Y   Y
+  smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a   =
 Y
+  smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y   =
 Y
+
+
+  Key:    C:      Ordering is cumulative
+	  P:      Ordering propagates
+	  R:      Read, for example, READ_ONCE(), or read portion of RMW
+	  W:      Write, for example, WRITE_ONCE(), or write portion of RMW
+	  Y:      Provides ordering
+	  a:      Provides ordering given intervening RMW atomic operation
+	  DR:     Dependent read (address dependency)
+	  DW:     Dependent write (address, data, or control dependency)
+	  RMW:    Atomic read-modify-write operation
+	  SELF:   Orders self, as opposed to accesses before and/or after
+	  SV:     Orders later accesses to the same variable
diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory=
-model/Documentation/cheatsheet.txt
deleted file mode 100644
index 33ba98d72b16..000000000000
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-                                  Prior Operation     Subsequent Operation
-                                  ---------------  -----------------------=
----
-                               C  Self  R  W  RMW  Self  R  W  DR  DW  RMW=
  SV
-                              --  ----  -  -  ---  ----  -  -  --  --  ---=
  --
-
-Store, e.g., WRITE_ONCE()            Y                                    =
   Y
-Load, e.g., READ_ONCE()              Y                          Y   Y     =
   Y
-Unsuccessful RMW operation           Y                          Y   Y     =
   Y
-rcu_dereference()                    Y                          Y   Y     =
   Y
-Successful *_acquire()               R                   Y  Y   Y   Y    Y=
   Y
-Successful *_release()         C        Y  Y    Y     W                   =
   Y
-smp_rmb()                               Y       R        Y      Y        R
-smp_wmb()                                  Y    W           Y       Y    W
-smp_mb() & synchronize_rcu()  CP        Y  Y    Y        Y  Y   Y   Y    Y
-Successful full non-void RMW  CP     Y  Y  Y    Y     Y  Y  Y   Y   Y    Y=
   Y
-smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
-smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
-
-
-Key:	C:	Ordering is cumulative
-	P:	Ordering propagates
-	R:	Read, for example, READ_ONCE(), or read portion of RMW
-	W:	Write, for example, WRITE_ONCE(), or write portion of RMW
-	Y:	Provides ordering
-	a:	Provides ordering given intervening RMW atomic operation
-	DR:	Dependent read (address dependency)
-	DW:	Dependent write (address, data, or control dependency)
-	RMW:	Atomic read-modify-write operation
-	SELF:	Orders self, as opposed to accesses before and/or after
-	SV:	Orders later accesses to the same variable
diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memor=
y-model/Documentation/explanation.rst
similarity index 92%
rename from tools/memory-model/Documentation/explanation.txt
rename to tools/memory-model/Documentation/explanation.rst
index 68caa9a976d0..9b5d10cef0c2 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.rst
@@ -1,5 +1,6 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
 Explanation of the Linux-Kernel Memory Consistency Model
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
=20
 :Author: Alan Stern <stern@rowland.harvard.edu>
 :Created: October 2017
@@ -107,7 +108,7 @@ and the flag are memory locations shared between the tw=
o CPUs.
=20
 We can abstract out the important pieces of the driver code as follows
 (the reason for using WRITE_ONCE() and READ_ONCE() instead of simple
-assignment statements is discussed later):
+assignment statements is discussed later)::
=20
 	int buf =3D 0, flag =3D 0;
=20
@@ -219,7 +220,7 @@ Ordering).  This model predicts that the undesired outc=
ome for the MP
 pattern cannot occur, but in other respects it differs from Sequential
 Consistency.  One example is the Store Buffer (SB) pattern, in which
 each CPU stores to its own shared location and then loads from the
-other CPU's location:
+other CPU's location::
=20
 	int x =3D 0, y =3D 0;
=20
@@ -264,7 +265,7 @@ The counterpart to ordering is a cycle.  Ordering rules=
 out cycles:
 It's not possible to have X ordered before Y, Y ordered before Z, and
 Z ordered before X, because this would mean that X is ordered before
 itself.  The analysis of the MP example under Sequential Consistency
-involved just such an impossible cycle:
+involved just such an impossible cycle::
=20
 	W: P0 stores 1 to flag   executes before
 	X: P1 loads 1 from flag  executes before
@@ -331,7 +332,7 @@ can think of it as the order in which statements occur =
in the source
 code after branches are taken into account and loops have been
 unrolled.  A better description might be the order in which
 instructions are presented to a CPU's execution unit.  Thus, we say
-that X is po-before Y (written as "X ->po Y" in formulas) if X occurs
+that X is po-before Y (written as ``X ->po Y`` in formulas) if X occurs
 before Y in the instruction stream.
=20
 This is inherently a single-CPU relation; two instructions executing
@@ -388,7 +389,7 @@ The protections provided by READ_ONCE(), WRITE_ONCE(), =
and others are
 not perfect; and under some circumstances it is possible for the
 compiler to undermine the memory model.  Here is an example.  Suppose
 both branches of an "if" statement store the same value to the same
-location:
+location::
=20
 	r1 =3D READ_ONCE(x);
 	if (r1) {
@@ -402,7 +403,7 @@ location:
 For this code, the LKMM predicts that the load from x will always be
 executed before either of the stores to y.  However, a compiler could
 lift the stores out of the conditional, transforming the code into
-something resembling:
+something resembling::
=20
 	r1 =3D READ_ONCE(x);
 	WRITE_ONCE(y, 2);
@@ -418,7 +419,7 @@ model's original prediction could be invalidated by the=
 compiler.
=20
 Another issue arises from the fact that in C, arguments to many
 operators and function calls can be evaluated in any order.  For
-example:
+example::
=20
 	r1 =3D f(5) + g(6);
=20
@@ -440,7 +441,7 @@ control (ctrl).
=20
 A read and a write event are linked by a data dependency if the value
 obtained by the read affects the value stored by the write.  As a very
-simple example:
+simple example::
=20
 	int x, y;
=20
@@ -455,7 +456,7 @@ values of multiple reads.
 A read event and another memory access event are linked by an address
 dependency if the value obtained by the read affects the location
 accessed by the other event.  The second event can be either a read or
-a write.  Here's another simple example:
+a write.  Here's another simple example::
=20
 	int a[20];
 	int i;
@@ -471,7 +472,7 @@ pointer.
=20
 Finally, a read event and another memory access event are linked by a
 control dependency if the value obtained by the read affects whether
-the second event is executed at all.  Simple example:
+the second event is executed at all.  Simple example::
=20
 	int x, y;
=20
@@ -484,9 +485,9 @@ which depends on the value obtained by the READ_ONCE();=
 hence there is
 a control dependency from the load to the store.
=20
 It should be pretty obvious that events can only depend on reads that
-come earlier in program order.  Symbolically, if we have R ->data X,
-R ->addr X, or R ->ctrl X (where R is a read event), then we must also
-have R ->po X.  It wouldn't make sense for a computation to depend
+come earlier in program order.  Symbolically, if we have ``R ->data X``,
+``R ->addr X``, or ``R ->ctrl X`` (where R is a read event), then we must =
also
+have ``R ->po X``.  It wouldn't make sense for a computation to depend
 somehow on a value that doesn't get loaded from shared memory until
 later in the code!
=20
@@ -497,7 +498,7 @@ THE READS-FROM RELATION: rf, rfi, and rfe
 The reads-from relation (rf) links a write event to a read event when
 the value loaded by the read is the value that was stored by the
 write.  In colloquial terms, the load "reads from" the store.  We
-write W ->rf R to indicate that the load R reads from the store W.  We
+write ``W ->rf R`` to indicate that the load R reads from the store W.  We
 further distinguish the cases where the load and the store occur on
 the same CPU (internal reads-from, or rfi) and where they occur on
 different CPUs (external reads-from, or rfe).
@@ -510,7 +511,7 @@ Usage of the rf relation implicitly assumes that loads =
will always
 read from a single store.  It doesn't apply properly in the presence
 of load-tearing, where a load obtains some of its bits from one store
 and some of them from another store.  Fortunately, use of READ_ONCE()
-and WRITE_ONCE() will prevent load-tearing; it's not possible to have:
+and WRITE_ONCE() will prevent load-tearing; it's not possible to have::
=20
 	int x =3D 0;
=20
@@ -530,7 +531,7 @@ and end up with r1 =3D 0x1200 (partly from x's initial =
value and partly
 from the value stored by P0).
=20
 On the other hand, load-tearing is unavoidable when mixed-size
-accesses are used.  Consider this example:
+accesses are used.  Consider this example::
=20
 	union {
 		u32	w;
@@ -578,26 +579,26 @@ that value comes third, and so on.
 You can think of the coherence order as being the order in which the
 stores reach x's location in memory (or if you prefer a more
 hardware-centric view, the order in which the stores get written to
-x's cache line).  We write W ->co W' if W comes before W' in the
+x's cache line).  We write ``W ->co W'`` if W comes before W' in the
 coherence order, that is, if the value stored by W gets overwritten,
 directly or indirectly, by the value stored by W'.
=20
 Coherence order is required to be consistent with program order.  This
 requirement takes the form of four coherency rules:
=20
-	Write-write coherence: If W ->po-loc W' (i.e., W comes before
+	Write-write coherence: If ``W ->po-loc W'`` (i.e., W comes before
 	W' in program order and they access the same location), where W
-	and W' are two stores, then W ->co W'.
+	and W' are two stores, then ``W ->co W'``.
=20
-	Write-read coherence: If W ->po-loc R, where W is a store and R
+	Write-read coherence: If ``W ->po-loc R``, where W is a store and R
 	is a load, then R must read from W or from some other store
 	which comes after W in the coherence order.
=20
-	Read-write coherence: If R ->po-loc W, where R is a load and W
+	Read-write coherence: If ``R ->po-loc W``, where R is a load and W
 	is a store, then the store which R reads from must come before
 	W in the coherence order.
=20
-	Read-read coherence: If R ->po-loc R', where R and R' are two
+	Read-read coherence: If ``R ->po-loc R'``, where R and R' are two
 	loads, then either they read from the same store or else the
 	store read by R comes before the store read by R' in the
 	coherence order.
@@ -612,7 +613,7 @@ requirement that every store eventually becomes visible=
 to every CPU.)
 Any reasonable memory model will include cache coherence.  Indeed, our
 expectation of cache coherence is so deeply ingrained that violations
 of its requirements look more like hardware bugs than programming
-errors:
+errors::
=20
 	int x;
=20
@@ -628,6 +629,8 @@ write-write coherence rule: Since the store of 23 comes=
 later in
 program order, it must also come later in x's coherence order and
 thus must overwrite the store of 17.
=20
+::
+
 	int x =3D 0;
=20
 	P0()
@@ -644,6 +647,8 @@ program order, so it must not read from that store but =
rather from one
 coming earlier in the coherence order (in this case, x's initial
 value).
=20
+::
+
 	int x =3D 0;
=20
 	P0()
@@ -689,12 +694,12 @@ THE FROM-READS RELATION: fr, fri, and fre
=20
 The from-reads relation (fr) can be a little difficult for people to
 grok.  It describes the situation where a load reads a value that gets
-overwritten by a store.  In other words, we have R ->fr W when the
+overwritten by a store.  In other words, we have ``R ->fr W`` when the
 value that R reads is overwritten (directly or indirectly) by W, or
 equivalently, when R reads from a store which comes earlier than W in
 the coherence order.
=20
-For example:
+For example::
=20
 	int x =3D 0;
=20
@@ -718,9 +723,11 @@ different CPUs).
=20
 Note that the fr relation is determined entirely by the rf and co
 relations; it is not independent.  Given a read event R and a write
-event W for the same location, we will have R ->fr W if and only if
+event W for the same location, we will have ``R ->fr W`` if and only if
 the write which R reads from is co-before W.  In symbols,
=20
+::
+
 	(R ->fr W) :=3D (there exists W' with W' ->rf R and W' ->co W).
=20
=20
@@ -843,13 +850,13 @@ defined to link memory access events E and F whenever:
 	event occurs between them in program order; or
=20
 	F is a release fence and some X comes before F in program order,
-	where either X =3D E or else E ->rf X; or
+	where either ``X =3D E`` or else ``E ->rf X``; or
=20
 	A strong fence event occurs between some X and F in program
-	order, where either X =3D E or else E ->rf X.
+	order, where either ``X =3D E`` or else ``E ->rf X``.
=20
 The operational model requires that whenever W and W' are both stores
-and W ->cumul-fence W', then W must propagate to any given CPU
+and ``W ->cumul-fence W'``, then W must propagate to any given CPU
 before W' does.  However, for different CPUs C and C', it does not
 require W to propagate to C before W' propagates to C'.
=20
@@ -903,11 +910,11 @@ first for CPU 0, then CPU 1, etc.
=20
 You can check that the four coherency rules imply that the rf, co, fr,
 and po-loc relations agree with this global ordering; in other words,
-whenever we have X ->rf Y or X ->co Y or X ->fr Y or X ->po-loc Y, the
+whenever we have ``X ->rf Y`` or ``X ->co Y`` or ``X ->fr Y`` or ``X ->po-=
loc Y``, the
 X event comes before the Y event in the global ordering.  The LKMM's
 "coherence" axiom expresses this by requiring the union of these
 relations not to have any cycles.  This means it must not be possible
-to find events
+to find events::
=20
 	X0 -> X1 -> X2 -> ... -> Xn -> X0,
=20
@@ -929,7 +936,7 @@ this case) does not get altered between the read and th=
e write events
 making up the atomic operation.  In particular, if two CPUs perform
 atomic_inc(&x) concurrently, it must be guaranteed that the final
 value of x will be the initial value plus two.  We should never have
-the following sequence of events:
+the following sequence of events::
=20
 	CPU 0 loads x obtaining 13;
 					CPU 1 loads x obtaining 13;
@@ -951,6 +958,8 @@ atomic read-modify-write and W' is the write event whic=
h R reads from,
 there must not be any stores coming between W' and W in the coherence
 order.  Equivalently,
=20
+::
+
 	(R ->rmw W) implies (there is no X with R ->fr X and X ->co W),
=20
 where the rmw relation links the read and write events making up each
@@ -968,7 +977,7 @@ po.
=20
 The operational model already includes a description of one such
 situation: Fences are a source of ppo links.  Suppose X and Y are
-memory accesses with X ->po Y; then the CPU must execute X before Y if
+memory accesses with ``X ->po Y``; then the CPU must execute X before Y if
 any of the following hold:
=20
 	A strong (smp_mb() or synchronize_rcu()) fence occurs between
@@ -987,7 +996,7 @@ any of the following hold:
 Another possibility, not mentioned earlier but discussed in the next
 section, is:
=20
-	X and Y are both loads, X ->addr Y (i.e., there is an address
+	X and Y are both loads, ``X ->addr Y`` (i.e., there is an address
 	dependency from X to Y), and X is a READ_ONCE() or an atomic
 	access.
=20
@@ -1021,7 +1030,7 @@ includes address dependencies to loads in the ppo rel=
ation.
=20
 On the other hand, dependencies can indirectly affect the ordering of
 two loads.  This happens when there is a dependency from a load to a
-store and a second, po-later load reads from that store:
+store and a second, po-later load reads from that store::
=20
 	R ->dep W ->rfi R',
=20
@@ -1036,7 +1045,7 @@ R; if the speculation turns out to be wrong then the =
CPU merely has to
 restart or abandon R'.
=20
 (In theory, a CPU might forward a store to a load when it runs across
-an address dependency like this:
+an address dependency like this::
=20
 	r1 =3D READ_ONCE(ptr);
 	WRITE_ONCE(*r1, 17);
@@ -1048,7 +1057,7 @@ However, none of the architectures supported by the L=
inux kernel do
 this.)
=20
 Two memory accesses of the same location must always be executed in
-program order if the second access is a store.  Thus, if we have
+program order if the second access is a store.  Thus, if we have::
=20
 	R ->po-loc W
=20
@@ -1056,7 +1065,7 @@ program order if the second access is a store.  Thus,=
 if we have
 access the same location), the CPU is obliged to execute W after R.
 If it executed W first then the memory subsystem would respond to R's
 read request with the value stored by W (or an even later store), in
-violation of the read-write coherence rule.  Similarly, if we had
+violation of the read-write coherence rule.  Similarly, if we had::
=20
 	W ->po-loc W'
=20
@@ -1074,7 +1083,7 @@ AND THEN THERE WAS ALPHA
=20
 As mentioned above, the Alpha architecture is unique in that it does
 not appear to respect address dependencies to loads.  This means that
-code such as the following:
+code such as the following::
=20
 	int x =3D 0;
 	int y =3D -1;
@@ -1128,7 +1137,7 @@ nothing at all on non-Alpha builds) after every READ_=
ONCE() and atomic
 load.  The effect of the fence is to cause the CPU not to execute any
 po-later instructions until after the local cache has finished
 processing all the stores it has already received.  Thus, if the code
-was changed to:
+was changed to::
=20
 	P1()
 	{
@@ -1167,25 +1176,25 @@ The happens-before relation (hb) links memory acces=
ses that have to
 execute in a certain order.  hb includes the ppo relation and two
 others, one of which is rfe.
=20
-W ->rfe R implies that W and R are on different CPUs.  It also means
+``W ->rfe R`` implies that W and R are on different CPUs.  It also means
 that W's store must have propagated to R's CPU before R executed;
 otherwise R could not have read the value stored by W.  Therefore W
-must have executed before R, and so we have W ->hb R.
+must have executed before R, and so we have ``W ->hb R``.
=20
-The equivalent fact need not hold if W ->rfi R (i.e., W and R are on
+The equivalent fact need not hold if ``W ->rfi R`` (i.e., W and R are on
 the same CPU).  As we have already seen, the operational model allows
 W's value to be forwarded to R in such cases, meaning that R may well
 execute before W does.
=20
 It's important to understand that neither coe nor fre is included in
 hb, despite their similarities to rfe.  For example, suppose we have
-W ->coe W'.  This means that W and W' are stores to the same location,
+``W ->coe W'``.  This means that W and W' are stores to the same location,
 they execute on different CPUs, and W comes before W' in the coherence
 order (i.e., W' overwrites W).  Nevertheless, it is possible for W' to
 execute before W, because the decision as to which store overwrites
 the other is made later by the memory subsystem.  When the stores are
 nearly simultaneous, either one can come out on top.  Similarly,
-R ->fre W means that W overwrites the value which R reads, but it
+``R ->fre W`` means that W overwrites the value which R reads, but it
 doesn't mean that W has to execute after R.  All that's necessary is
 for the memory subsystem not to propagate W to R's CPU until after R
 has executed, which is possible if W executes shortly before R.
@@ -1199,7 +1208,7 @@ the first event in the coherence order and propagates=
 to C before the
 second event executes.
=20
 This is best explained with some examples.  The simplest case looks
-like this:
+like this::
=20
 	int x;
=20
@@ -1225,7 +1234,7 @@ event, because P1's store came after P0's store in x'=
s coherence
 order, and P1's store propagated to P0 before P0's load executed.
=20
 An equally simple case involves two loads of the same location that
-read from different stores:
+read from different stores::
=20
 	int x =3D 0;
=20
@@ -1252,7 +1261,7 @@ P1's store propagated to P0 before P0's second load e=
xecuted.
=20
 Less trivial examples of prop all involve fences.  Unlike the simple
 examples above, they can require that some instructions are executed
-out of program order.  This next one should look familiar:
+out of program order.  This next one should look familiar::
=20
 	int buf =3D 0, flag =3D 0;
=20
@@ -1303,7 +1312,7 @@ rfe link.  You can concoct more exotic examples, cont=
aining more than
 one fence, although this quickly leads to diminishing returns in terms
 of complexity.  For instance, here's an example containing a coe link
 followed by two fences and an rfe link, utilizing the fact that
-release fences are A-cumulative:
+release fences are A-cumulative::
=20
 	int x, y, z;
=20
@@ -1363,7 +1372,7 @@ links.  Let's see how this definition works out.
=20
 Consider first the case where E is a store (implying that the sequence
 of links begins with coe).  Then there are events W, X, Y, and Z such
-that:
+that::
=20
 	E ->coe W ->cumul-fence* X ->rfe? Y ->strong-fence Z ->hb* F,
=20
@@ -1384,13 +1393,13 @@ The existence of a pb link from E to F implies that=
 E must execute
 before F.  To see why, suppose that F executed first.  Then W would
 have propagated to E's CPU before E executed.  If E was a store, the
 memory subsystem would then be forced to make E come after W in the
-coherence order, contradicting the fact that E ->coe W.  If E was a
+coherence order, contradicting the fact that ``E ->coe W``.  If E was a
 load, the memory subsystem would then be forced to satisfy E's read
 request with the value stored by W or an even later store,
-contradicting the fact that E ->fre W.
+contradicting the fact that ``E ->fre W``.
=20
 A good example illustrating how pb works is the SB pattern with strong
-fences:
+fences::
=20
 	int x =3D 0, y =3D 0;
=20
@@ -1449,18 +1458,18 @@ span a full grace period.  In more detail, the Guar=
antee says:
 	For any critical section C and any grace period G, at least
 	one of the following statements must hold:
=20
-(1)	C ends before G does, and in addition, every store that
-	propagates to C's CPU before the end of C must propagate to
-	every CPU before G ends.
+	(1)	C ends before G does, and in addition, every store that
+		propagates to C's CPU before the end of C must propagate to
+		every CPU before G ends.
=20
-(2)	G starts before C does, and in addition, every store that
-	propagates to G's CPU before the start of G must propagate
-	to every CPU before C starts.
+	(2)	G starts before C does, and in addition, every store that
+		propagates to G's CPU before the start of G must propagate
+		to every CPU before C starts.
=20
 In particular, it is not possible for a critical section to both start
 before and end after a grace period.
=20
-Here is a simple example of RCU in action:
+Here is a simple example of RCU in action::
=20
 	int x, y;
=20
@@ -1509,9 +1518,9 @@ entirely clear.  The LKMM formalizes this notion by m=
eans of the
 rcu-link relation.  rcu-link encompasses a very general notion of
 "before": If E and F are RCU fence events (i.e., rcu_read_lock(),
 rcu_read_unlock(), or synchronize_rcu()) then among other things,
-E ->rcu-link F includes cases where E is po-before some memory-access
+``E ->rcu-link F`` includes cases where E is po-before some memory-access
 event X, F is po-after some memory-access event Y, and we have any of
-X ->rfe Y, X ->co Y, or X ->fr Y.
+``X ->rfe Y``, ``X ->co Y``, or ``X ->fr Y``.
=20
 The formal definition of the rcu-link relation is more than a little
 obscure, and we won't give it here.  It is closely related to the pb
@@ -1523,50 +1532,50 @@ The LKMM also defines the rcu-gp and rcu-rscsi rela=
tions.  They bring
 grace periods and read-side critical sections into the picture, in the
 following way:
=20
-	E ->rcu-gp F means that E and F are in fact the same event,
+	``E ->rcu-gp F`` means that E and F are in fact the same event,
 	and that event is a synchronize_rcu() fence (i.e., a grace
 	period).
=20
-	E ->rcu-rscsi F means that E and F are the rcu_read_unlock()
+	``E ->rcu-rscsi F`` means that E and F are the rcu_read_unlock()
 	and rcu_read_lock() fence events delimiting some read-side
 	critical section.  (The 'i' at the end of the name emphasizes
 	that this relation is "inverted": It links the end of the
 	critical section to the start.)
=20
 If we think of the rcu-link relation as standing for an extended
-"before", then X ->rcu-gp Y ->rcu-link Z roughly says that X is a
+"before", then ``X ->rcu-gp Y ->rcu-link Z`` roughly says that X is a
 grace period which ends before Z begins.  (In fact it covers more than
 this, because it also includes cases where some store propagates to
 Z's CPU before Z begins but doesn't propagate to some other CPU until
-after X ends.)  Similarly, X ->rcu-rscsi Y ->rcu-link Z says that X is
+after X ends.)  Similarly, ``X ->rcu-rscsi Y ->rcu-link Z`` says that X is
 the end of a critical section which starts before Z begins.
=20
 The LKMM goes on to define the rcu-fence relation as a sequence of
 rcu-gp and rcu-rscsi links separated by rcu-link links, in which the
 number of rcu-gp links is >=3D the number of rcu-rscsi links.  For
-example:
+example::
=20
 	X ->rcu-gp Y ->rcu-link Z ->rcu-rscsi T ->rcu-link U ->rcu-gp V
=20
-would imply that X ->rcu-fence V, because this sequence contains two
+would imply that ``X ->rcu-fence V``, because this sequence contains two
 rcu-gp links and one rcu-rscsi link.  (It also implies that
-X ->rcu-fence T and Z ->rcu-fence V.)  On the other hand:
+``X ->rcu-fence T`` and ``Z ->rcu-fence V``.)  On the other hand::
=20
 	X ->rcu-rscsi Y ->rcu-link Z ->rcu-rscsi T ->rcu-link U ->rcu-gp V
=20
-does not imply X ->rcu-fence V, because the sequence contains only
+does not imply ``X ->rcu-fence V``, because the sequence contains only
 one rcu-gp link but two rcu-rscsi links.
=20
 The rcu-fence relation is important because the Grace Period Guarantee
 means that rcu-fence acts kind of like a strong fence.  In particular,
-E ->rcu-fence F implies not only that E begins before F ends, but also
+``E ->rcu-fence F`` implies not only that E begins before F ends, but also
 that any write po-before E will propagate to every CPU before any
 instruction po-after F can execute.  (However, it does not imply that
 E must execute before F; in fact, each synchronize_rcu() fence event
 is linked to itself by rcu-fence as a degenerate case.)
=20
 To prove this in full generality requires some intellectual effort.
-We'll consider just a very simple case:
+We'll consider just a very simple case::
=20
 	G ->rcu-gp W ->rcu-link Z ->rcu-rscsi F.
=20
@@ -1595,13 +1604,13 @@ covered by rcu-fence.
 Finally, the LKMM defines the RCU-before (rb) relation in terms of
 rcu-fence.  This is done in essentially the same way as the pb
 relation was defined in terms of strong-fence.  We will omit the
-details; the end result is that E ->rb F implies E must execute
-before F, just as E ->pb F does (and for much the same reasons).
+details; the end result is that ``E ->rb F`` implies E must execute
+before F, just as ``E ->pb F`` does (and for much the same reasons).
=20
 Putting this all together, the LKMM expresses the Grace Period
 Guarantee by requiring that the rb relation does not contain a cycle.
 Equivalently, this "rcu" axiom requires that there are no events E
-and F with E ->rcu-link F ->rcu-fence E.  Or to put it a third way,
+and F with ``E ->rcu-link F ->rcu-fence E``.  Or to put it a third way,
 the axiom requires that there are no cycles consisting of rcu-gp and
 rcu-rscsi alternating with rcu-link, where the number of rcu-gp links
 is >=3D the number of rcu-rscsi links.
@@ -1621,7 +1630,7 @@ question, and let S be the synchronize_rcu() fence ev=
ent for the grace
 period.  Saying that the critical section starts before S means there
 are events Q and R where Q is po-after L (which marks the start of the
 critical section), Q is "before" R in the sense used by the rcu-link
-relation, and R is po-before the grace period S.  Thus we have:
+relation, and R is po-before the grace period S.  Thus we have::
=20
 	L ->rcu-link S.
=20
@@ -1629,20 +1638,20 @@ Let W be the store mentioned above, let Y come befo=
re the end of the
 critical section and witness that W propagates to the critical
 section's CPU by reading from W, and let Z on some arbitrary CPU be a
 witness that W has not propagated to that CPU, where Z happens after
-some event X which is po-after S.  Symbolically, this amounts to:
+some event X which is po-after S.  Symbolically, this amounts to::
=20
 	S ->po X ->hb* Z ->fr W ->rf Y ->po U.
=20
 The fr link from Z to W indicates that W has not propagated to Z's CPU
 at the time that Z executes.  From this, it can be shown (see the
 discussion of the rcu-link relation earlier) that S and U are related
-by rcu-link:
+by rcu-link::
=20
 	S ->rcu-link U.
=20
-Since S is a grace period we have S ->rcu-gp S, and since L and U are
-the start and end of the critical section C we have U ->rcu-rscsi L.
-From this we obtain:
+Since S is a grace period we have ``S ->rcu-gp S``, and since L and U are
+the start and end of the critical section C we have ``U ->rcu-rscsi L``.
+From this we obtain::
=20
 	S ->rcu-gp S ->rcu-link U ->rcu-rscsi L ->rcu-link S,
=20
@@ -1651,7 +1660,7 @@ the Grace Period Guarantee.
=20
 For something a little more down-to-earth, let's see how the axiom
 works out in practice.  Consider the RCU code example from above, this
-time with statement labels added:
+time with statement labels added::
=20
 	int x, y;
=20
@@ -1674,20 +1683,20 @@ time with statement labels added:
=20
=20
 If r2 =3D 0 at the end then P0's store at Y overwrites the value that
-P1's load at W reads from, so we have W ->fre Y.  Since S ->po W and
-also Y ->po U, we get S ->rcu-link U.  In addition, S ->rcu-gp S
+P1's load at W reads from, so we have ``W ->fre Y``.  Since ``S ->po W`` a=
nd
+also ``Y ->po U``, we get ``S ->rcu-link U``.  In addition, ``S ->rcu-gp S=
``
 because S is a grace period.
=20
 If r1 =3D 1 at the end then P1's load at Z reads from P0's store at X,
-so we have X ->rfe Z.  Together with L ->po X and Z ->po S, this
-yields L ->rcu-link S.  And since L and U are the start and end of a
-critical section, we have U ->rcu-rscsi L.
+so we have ``X ->rfe Z``.  Together with ``L ->po X`` and ``Z ->po S``, th=
is
+yields ``L ->rcu-link S``.  And since L and U are the start and end of a
+critical section, we have ``U ->rcu-rscsi L``.
=20
-Then U ->rcu-rscsi L ->rcu-link S ->rcu-gp S ->rcu-link U is a
+Then ``U ->rcu-rscsi L ->rcu-link S ->rcu-gp S ->rcu-link U`` is a
 forbidden cycle, violating the "rcu" axiom.  Hence the outcome is not
 allowed by the LKMM, as we would expect.
=20
-For contrast, let's see what can happen in a more complicated example:
+For contrast, let's see what can happen in a more complicated example::
=20
 	int x, y, z;
=20
@@ -1720,28 +1729,28 @@ For contrast, let's see what can happen in a more c=
omplicated example:
 		U2: rcu_read_unlock();
 	}
=20
-If r0 =3D r1 =3D r2 =3D 1 at the end, then similar reasoning to before sho=
ws
-that U0 ->rcu-rscsi L0 ->rcu-link S1 ->rcu-gp S1 ->rcu-link U2 ->rcu-rscsi
-L2 ->rcu-link U0.  However this cycle is not forbidden, because the
+If ``r0 =3D r1 =3D r2 =3D 1`` at the end, then similar reasoning to before=
 shows
+that ``U0 ->rcu-rscsi L0 ->rcu-link S1 ->rcu-gp S1 ->rcu-link U2 ->rcu-rsc=
si
+L2 ->rcu-link U0``.  However this cycle is not forbidden, because the
 sequence of relations contains fewer instances of rcu-gp (one) than of
 rcu-rscsi (two).  Consequently the outcome is allowed by the LKMM.
 The following instruction timing diagram shows how it might actually
-occur:
-
-P0			P1			P2
---------------------	--------------------	--------------------
-rcu_read_lock()
-WRITE_ONCE(y, 1)
-			r1 =3D READ_ONCE(y)
-			synchronize_rcu() starts
-			.			rcu_read_lock()
-			.			WRITE_ONCE(x, 1)
-r0 =3D READ_ONCE(x)	.
-rcu_read_unlock()	.
-			synchronize_rcu() ends
-			WRITE_ONCE(z, 1)
-						r2 =3D READ_ONCE(z)
-						rcu_read_unlock()
+occur::
+
+	P0			P1			P2
+	--------------------	--------------------	--------------------
+	rcu_read_lock()
+	WRITE_ONCE(y, 1)
+				r1 =3D READ_ONCE(y)
+				synchronize_rcu() starts
+				.			rcu_read_lock()
+				.			WRITE_ONCE(x, 1)
+	r0 =3D READ_ONCE(x)	.
+	rcu_read_unlock()	.
+				synchronize_rcu() ends
+				WRITE_ONCE(z, 1)
+							r2 =3D READ_ONCE(z)
+							rcu_read_unlock()
=20
 This requires P0 and P2 to execute their loads and stores out of
 program order, but of course they are allowed to do so.  And as you
@@ -1767,26 +1776,26 @@ The LKMM includes locking.  In fact, there is speci=
al code for locking
 in the formal model, added in order to make tools run faster.
 However, this special code is intended to be more or less equivalent
 to concepts we have already covered.  A spinlock_t variable is treated
-the same as an int, and spin_lock(&s) is treated almost the same as:
+the same as an int, and spin_lock(&s) is treated almost the same as::
=20
 	while (cmpxchg_acquire(&s, 0, 1) !=3D 0)
 		cpu_relax();
=20
 This waits until s is equal to 0 and then atomically sets it to 1,
 and the read part of the cmpxchg operation acts as an acquire fence.
-An alternate way to express the same thing would be:
+An alternate way to express the same thing would be::
=20
 	r =3D xchg_acquire(&s, 1);
=20
 along with a requirement that at the end, r =3D 0.  Similarly,
-spin_trylock(&s) is treated almost the same as:
+spin_trylock(&s) is treated almost the same as::
=20
 	return !cmpxchg_acquire(&s, 0, 1);
=20
 which atomically sets s to 1 if it is currently equal to 0 and returns
 true if it succeeds (the read part of the cmpxchg operation acts as an
 acquire fence only if the operation is successful).  spin_unlock(&s)
-is treated almost the same as:
+is treated almost the same as::
=20
 	smp_store_release(&s, 0);
=20
@@ -1802,7 +1811,7 @@ requires that every instruction po-before the lock-re=
lease must
 execute before any instruction po-after the lock-acquire.  This would
 naturally hold if the release and acquire operations were on different
 CPUs, but the LKMM says it holds even when they are on the same CPU.
-For example:
+For example::
=20
 	int x, y;
 	spinlock_t s;
@@ -1833,7 +1842,7 @@ MP pattern).
=20
 This requirement does not apply to ordinary release and acquire
 fences, only to lock-related operations.  For instance, suppose P0()
-in the example had been written as:
+in the example had been written as::
=20
 	P0()
 	{
@@ -1847,7 +1856,7 @@ in the example had been written as:
=20
 Then the CPU would be allowed to forward the s =3D 1 value from the
 smp_store_release() to the smp_load_acquire(), executing the
-instructions in the following order:
+instructions in the following order::
=20
 		r3 =3D smp_load_acquire(&s);	// Obtains r3 =3D 1
 		r2 =3D READ_ONCE(y);
@@ -1859,7 +1868,7 @@ and thus it could load y before x, obtaining r2 =3D 0=
 and r1 =3D 1.
 Second, when a lock-acquire reads from a lock-release, and some other
 stores W and W' occur po-before the lock-release and po-after the
 lock-acquire respectively, the LKMM requires that W must propagate to
-each CPU before W' does.  For example, consider:
+each CPU before W' does.  For example, consider::
=20
 	int x, y;
 	spinlock_t x;
@@ -1928,7 +1937,7 @@ smp_store_release().)  The final effect is the same.
 Although we didn't mention it above, the instruction execution
 ordering provided by the smp_rmb() fence doesn't apply to read events
 that are part of a non-value-returning atomic update.  For instance,
-given:
+given::
=20
 	atomic_inc(&x);
 	smp_rmb();
@@ -1967,14 +1976,14 @@ they behave as follows:
 	events.
=20
 Interestingly, RCU and locking each introduce the possibility of
-deadlock.  When faced with code sequences such as:
+deadlock.  When faced with code sequences such as::
=20
 	spin_lock(&s);
 	spin_lock(&s);
 	spin_unlock(&s);
 	spin_unlock(&s);
=20
-or:
+or::
=20
 	rcu_read_lock();
 	synchronize_rcu();
@@ -1984,7 +1993,7 @@ what does the LKMM have to say?  Answer: It says ther=
e are no allowed
 executions at all, which makes sense.  But this can also lead to
 misleading results, because if a piece of code has multiple possible
 executions, some of which deadlock, the model will report only on the
-non-deadlocking executions.  For example:
+non-deadlocking executions.  For example::
=20
 	int x, y;
=20
diff --git a/tools/memory-model/Documentation/index.rst b/tools/memory-mode=
l/Documentation/index.rst
new file mode 100644
index 000000000000..0e53d83a5a48
--- /dev/null
+++ b/tools/memory-model/Documentation/index.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Linux Memory Model Tools
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. toctree::
+   :maxdepth: 1
+
+   explanation
+   recipes
+   references
+   cheatsheet
+
+.. only::  subproject and html
+
+   Indices
+   =3D=3D=3D=3D=3D=3D=3D
+
+   * :ref:`genindex`
diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-mo=
del/Documentation/recipes.rst
similarity index 96%
rename from tools/memory-model/Documentation/recipes.txt
rename to tools/memory-model/Documentation/recipes.rst
index 7fe8d7aa3029..0229a431b1a2 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.rst
@@ -1,3 +1,8 @@
+=3D=3D=3D=3D=3D=3D=3D
+Recipes
+=3D=3D=3D=3D=3D=3D=3D
+
+
 This document provides "recipes", that is, litmus tests for commonly
 occurring situations, as well as a few that illustrate subtly broken but
 attractive nuisances.  Many of these recipes include example code from
@@ -67,7 +72,7 @@ has acquired a given lock sees any changes previously see=
n or made by any
 CPU before it released that same lock.  Note that this statement is a bit
 stronger than "Any CPU holding a given lock sees all changes made by any
 CPU during the time that CPU was holding this same lock".  For example,
-consider the following pair of code fragments:
+consider the following pair of code fragments::
=20
 	/* See MP+polocks.litmus. */
 	void CPU0(void)
@@ -93,7 +98,7 @@ value of r1 must also be equal to 1.  In contrast, the we=
aker rule would
 say nothing about the final value of r1.
=20
 The converse to the basic rule also holds, as illustrated by the
-following litmus test:
+following litmus test::
=20
 	/* See MP+porevlocks.litmus. */
 	void CPU0(void)
@@ -124,7 +129,7 @@ across multiple CPUs.
=20
 However, it is not necessarily the case that accesses ordered by
 locking will be seen as ordered by CPUs not holding that lock.
-Consider this example:
+Consider this example::
=20
 	/* See Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus. */
 	void CPU0(void)
@@ -157,7 +162,7 @@ CPU2() never acquired the lock, and thus did not benefi=
t from the
 lock's ordering properties.
=20
 Ordering can be extended to CPUs not holding the lock by careful use
-of smp_mb__after_spinlock():
+of smp_mb__after_spinlock()::
=20
 	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
 	void CPU0(void)
@@ -214,7 +219,7 @@ Release and acquire
 ~~~~~~~~~~~~~~~~~~~
=20
 Use of smp_store_release() and smp_load_acquire() is one way to force
-the desired MP ordering.  The general approach is shown below:
+the desired MP ordering.  The general approach is shown below::
=20
 	/* See MP+pooncerelease+poacquireonce.litmus. */
 	void CPU0(void)
@@ -245,7 +250,7 @@ Assign and dereference
 Use of rcu_assign_pointer() and rcu_dereference() is quite similar to the
 use of smp_store_release() and smp_load_acquire(), except that both
 rcu_assign_pointer() and rcu_dereference() operate on RCU-protected
-pointers.  The general approach is shown below:
+pointers.  The general approach is shown below::
=20
 	/* See MP+onceassign+derefonce.litmus. */
 	int z;
@@ -290,7 +295,7 @@ Write and read memory barriers
 It is usually better to use smp_store_release() instead of smp_wmb()
 and to use smp_load_acquire() instead of smp_rmb().  However, the older
 smp_wmb() and smp_rmb() APIs are still heavily used, so it is important
-to understand their use cases.  The general approach is shown below:
+to understand their use cases.  The general approach is shown below::
=20
 	/* See MP+fencewmbonceonce+fencermbonceonce.litmus. */
 	void CPU0(void)
@@ -312,7 +317,7 @@ smp_rmb() macro orders prior loads against later loads.=
  Therefore, if
 the final value of r0 is 1, the final value of r1 must also be 1.
=20
 The xlog_state_switch_iclogs() function in fs/xfs/xfs_log.c contains
-the following write-side code fragment:
+the following write-side code fragment::
=20
 	log->l_curr_block -=3D log->l_logBBsize;
 	ASSERT(log->l_curr_block >=3D 0);
@@ -327,7 +332,7 @@ the corresponding read-side code fragment:
 	cur_block =3D READ_ONCE(log->l_curr_block);
=20
 Alternatively, consider the following comment in function
-perf_output_put_handle() in kernel/events/ring_buffer.c:
+perf_output_put_handle() in kernel/events/ring_buffer.c::
=20
 	 *   kernel				user
 	 *
@@ -358,7 +363,7 @@ absence of any ordering it is quite possible that this =
may happen, as
 can be seen in the LB+poonceonces.litmus litmus test.
=20
 One way of avoiding the counter-intuitive outcome is through the use of a
-control dependency paired with a full memory barrier:
+control dependency paired with a full memory barrier::
=20
 	/* See LB+fencembonceonce+ctrlonceonce.litmus. */
 	void CPU0(void)
@@ -382,7 +387,7 @@ The A/D pairing from the ring-buffer use case shown ear=
lier also
 illustrates LB.  Here is a repeat of the comment in
 perf_output_put_handle() in kernel/events/ring_buffer.c, showing a
 control dependency on the kernel side and a full memory barrier on
-the user side:
+the user side::
=20
 	 *   kernel				user
 	 *
@@ -407,7 +412,7 @@ Release-acquire chains
=20
 Release-acquire chains are a low-overhead, flexible, and easy-to-use
 method of maintaining order.  However, they do have some limitations that
-need to be fully understood.  Here is an example that maintains order:
+need to be fully understood.  Here is an example that maintains order::
=20
 	/* See ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus. */
 	void CPU0(void)
@@ -436,7 +441,7 @@ example, ordering would still be preserved if CPU1()'s =
smp_load_acquire()
 invocation was replaced with READ_ONCE().
=20
 It is tempting to assume that CPU0()'s store to x is globally ordered
-before CPU1()'s store to z, but this is not the case:
+before CPU1()'s store to z, but this is not the case::
=20
 	/* See Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus. */
 	void CPU0(void)
@@ -474,7 +479,7 @@ Store buffering
 Store buffering can be thought of as upside-down load buffering, so
 that one CPU first stores to one variable and then loads from a second,
 while another CPU stores to the second variable and then loads from the
-first.  Preserving order requires nothing less than full barriers:
+first.  Preserving order requires nothing less than full barriers::
=20
 	/* See SB+fencembonceonces.litmus. */
 	void CPU0(void)
@@ -498,7 +503,7 @@ this counter-intuitive outcome.
 This pattern most famously appears as part of Dekker's locking
 algorithm, but it has a much more practical use within the Linux kernel
 of ordering wakeups.  The following comment taken from waitqueue_active()
-in include/linux/wait.h shows the canonical pattern:
+in include/linux/wait.h shows the canonical pattern::
=20
  *      CPU0 - waker                    CPU1 - waiter
  *
@@ -550,16 +555,16 @@ The strength of memory ordering required for a given =
litmus test to
 avoid a counter-intuitive outcome depends on the types of relations
 linking the memory accesses for the outcome in question:
=20
-o	If all links are write-to-read links, then the weakest
+-	If all links are write-to-read links, then the weakest
 	possible ordering within each CPU suffices.  For example, in
 	the LB litmus test, a control dependency was enough to do the
 	job.
=20
-o	If all but one of the links are write-to-read links, then a
+-	If all but one of the links are write-to-read links, then a
 	release-acquire chain suffices.  Both the MP and the ISA2
 	litmus tests illustrate this case.
=20
-o	If more than one of the links are something other than
+-	If more than one of the links are something other than
 	write-to-read links, then a full memory barrier is required
 	between each successive pair of non-write-to-read links.  This
 	case is illustrated by the Z6.0 litmus tests, both in the
diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory=
-model/Documentation/references.rst
similarity index 71%
rename from tools/memory-model/Documentation/references.txt
rename to tools/memory-model/Documentation/references.rst
index b177f3e4a614..275876cd10b8 100644
--- a/tools/memory-model/Documentation/references.txt
+++ b/tools/memory-model/Documentation/references.rst
@@ -1,3 +1,7 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+References
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
 This document provides background reading for memory models and related
 tools.  These documents are aimed at kernel hackers who are interested
 in memory models.
@@ -6,64 +10,64 @@ in memory models.
 Hardware manuals and models
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
=20
-o	SPARC International Inc. (Ed.). 1994. "The SPARC Architecture
+-	SPARC International Inc. (Ed.). 1994. "The SPARC Architecture
 	Reference Manual Version 9". SPARC International Inc.
=20
-o	Compaq Computer Corporation (Ed.). 2002. "Alpha Architecture
+-	Compaq Computer Corporation (Ed.). 2002. "Alpha Architecture
 	Reference Manual".  Compaq Computer Corporation.
=20
-o	Intel Corporation (Ed.). 2002. "A Formal Specification of Intel
+-	Intel Corporation (Ed.). 2002. "A Formal Specification of Intel
 	Itanium Processor Family Memory Ordering". Intel Corporation.
=20
-o	Intel Corporation (Ed.). 2002. "Intel 64 and IA-32 Architectures
+-	Intel Corporation (Ed.). 2002. "Intel 64 and IA-32 Architectures
 	Software Developer=E2=80=99s Manual". Intel Corporation.
=20
-o	Peter Sewell, Susmit Sarkar, Scott Owens, Francesco Zappa Nardelli,
+-	Peter Sewell, Susmit Sarkar, Scott Owens, Francesco Zappa Nardelli,
 	and Magnus O. Myreen. 2010. "x86-TSO: A Rigorous and Usable
 	Programmer's Model for x86 Multiprocessors". Commun. ACM 53, 7
 	(July, 2010), 89-97. http://doi.acm.org/10.1145/1785414.1785443
=20
-o	IBM Corporation (Ed.). 2009. "Power ISA Version 2.06". IBM
+-	IBM Corporation (Ed.). 2009. "Power ISA Version 2.06". IBM
 	Corporation.
=20
-o	ARM Ltd. (Ed.). 2009. "ARM Barrier Litmus Tests and Cookbook".
+-	ARM Ltd. (Ed.). 2009. "ARM Barrier Litmus Tests and Cookbook".
 	ARM Ltd.
=20
-o	Susmit Sarkar, Peter Sewell, Jade Alglave, Luc Maranget, and
+-	Susmit Sarkar, Peter Sewell, Jade Alglave, Luc Maranget, and
 	Derek Williams.  2011. "Understanding POWER Multiprocessors". In
 	Proceedings of the 32Nd ACM SIGPLAN Conference on Programming
 	Language Design and Implementation (PLDI =E2=80=9911). ACM, New York,
 	NY, USA, 175=E2=80=93186.
=20
-o	Susmit Sarkar, Kayvan Memarian, Scott Owens, Mark Batty,
+-	Susmit Sarkar, Kayvan Memarian, Scott Owens, Mark Batty,
 	Peter Sewell, Luc Maranget, Jade Alglave, and Derek Williams.
 	2012. "Synchronising C/C++ and POWER". In Proceedings of the 33rd
 	ACM SIGPLAN Conference on Programming Language Design and
 	Implementation (PLDI '12). ACM, New York, NY, USA, 311-322.
=20
-o	ARM Ltd. (Ed.). 2014. "ARM Architecture Reference Manual (ARMv8,
+-	ARM Ltd. (Ed.). 2014. "ARM Architecture Reference Manual (ARMv8,
 	for ARMv8-A architecture profile)". ARM Ltd.
=20
-o	Imagination Technologies, LTD. 2015. "MIPS(R) Architecture
+-	Imagination Technologies, LTD. 2015. "MIPS(R) Architecture
 	For Programmers, Volume II-A: The MIPS64(R) Instruction,
 	Set Reference Manual". Imagination Technologies,
 	LTD. https://imgtec.com/?do-download=3D4302.
=20
-o	Shaked Flur, Kathryn E. Gray, Christopher Pulte, Susmit
+-	Shaked Flur, Kathryn E. Gray, Christopher Pulte, Susmit
 	Sarkar, Ali Sezgin, Luc Maranget, Will Deacon, and Peter
 	Sewell. 2016. "Modelling the ARMv8 Architecture, Operationally:
 	Concurrency and ISA". In Proceedings of the 43rd Annual ACM
 	SIGPLAN-SIGACT Symposium on Principles of Programming Languages
 	(POPL =E2=80=9916). ACM, New York, NY, USA, 608=E2=80=93621.
=20
-o	Shaked Flur, Susmit Sarkar, Christopher Pulte, Kyndylan Nienhuis,
+-	Shaked Flur, Susmit Sarkar, Christopher Pulte, Kyndylan Nienhuis,
 	Luc Maranget, Kathryn E. Gray, Ali Sezgin, Mark Batty, and Peter
 	Sewell. 2017. "Mixed-size Concurrency: ARM, POWER, C/C++11,
 	and SC". In Proceedings of the 44th ACM SIGPLAN Symposium on
 	Principles of Programming Languages (POPL 2017). ACM, New York,
 	NY, USA, 429=E2=80=93442.
=20
-o	Christopher Pulte, Shaked Flur, Will Deacon, Jon French,
+-	Christopher Pulte, Shaked Flur, Will Deacon, Jon French,
 	Susmit Sarkar, and Peter Sewell. 2018. "Simplifying ARM concurrency:
 	multicopy-atomic axiomatic and operational models for ARMv8". In
 	Proceedings of the ACM on Programming Languages, Volume 2, Issue
@@ -73,18 +77,18 @@ o	Christopher Pulte, Shaked Flur, Will Deacon, Jon Fren=
ch,
 Linux-kernel memory model
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
+-	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
 	Alan Stern.  2018. "Frightening small children and disconcerting
 	grown-ups: Concurrency in the Linux kernel". In Proceedings of
 	the 23rd International Conference on Architectural Support for
 	Programming Languages and Operating Systems (ASPLOS 2018). ACM,
 	New York, NY, USA, 405-418.  Webpage: http://diy.inria.fr/linux/.
=20
-o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
+-	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
 	Alan Stern.  2017.  "A formal kernel memory-ordering model (part 1)"
 	Linux Weekly News.  https://lwn.net/Articles/718628/
=20
-o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
+-	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
 	Alan Stern.  2017.  "A formal kernel memory-ordering model (part 2)"
 	Linux Weekly News.  https://lwn.net/Articles/720550/
=20
@@ -92,16 +96,16 @@ o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea =
Parri, and
 Memory-model tooling
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-o	Daniel Jackson. 2002. "Alloy: A Lightweight Object Modelling
+-	Daniel Jackson. 2002. "Alloy: A Lightweight Object Modelling
 	Notation". ACM Trans. Softw. Eng. Methodol. 11, 2 (April 2002),
 	256=E2=80=93290. http://doi.acm.org/10.1145/505145.505149
=20
-o	Jade Alglave, Luc Maranget, and Michael Tautschnig. 2014. "Herding
+-	Jade Alglave, Luc Maranget, and Michael Tautschnig. 2014. "Herding
 	Cats: Modelling, Simulation, Testing, and Data Mining for Weak
 	Memory". ACM Trans. Program. Lang. Syst. 36, 2, Article 7 (July
 	2014), 7:1=E2=80=937:74 pages.
=20
-o	Jade Alglave, Patrick Cousot, and Luc Maranget. 2016. "Syntax and
+-	Jade Alglave, Patrick Cousot, and Luc Maranget. 2016. "Syntax and
 	semantics of the weak consistency model specification language
 	cat". CoRR abs/1608.07531 (2016). http://arxiv.org/abs/1608.07531
=20
@@ -109,6 +113,6 @@ o	Jade Alglave, Patrick Cousot, and Luc Maranget. 2016.=
 "Syntax and
 Memory-model comparisons
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-o	Paul E. McKenney, Ulrich Weigand, Andrea Parri, and Boqun
+-	Paul E. McKenney, Ulrich Weigand, Andrea Parri, and Boqun
 	Feng. 2016. "Linux-Kernel Memory Model". (6 June 2016).
 	http://open-std.org/JTC1/SC22/WG21/docs/papers/2016/p0124r2.html.
diff --git a/tools/memory-model/README b/tools/memory-model/README
index 2b87f3971548..04bb1fa9ed76 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -105,16 +105,16 @@ for more information.
 DESCRIPTION OF FILES
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Documentation/cheatsheet.txt
+Documentation/cheatsheet.rst
 	Quick-reference guide to the Linux-kernel memory model.
=20
-Documentation/explanation.txt
+Documentation/explanation.rst
 	Describes the memory model in detail.
=20
-Documentation/recipes.txt
+Documentation/recipes.rst
 	Lists common memory-ordering patterns.
=20
-Documentation/references.txt
+Documentation/references.rst
 	Provides background reading.
=20
 linux-kernel.bell
@@ -173,7 +173,7 @@ The Linux-kernel memory model has the following limitat=
ions:
 	of READ_ONCE() and WRITE_ONCE() limits the compiler's ability
 	to optimize, but there is Linux-kernel code that uses bare C
 	memory accesses.  Handling this code is on the to-do list.
-	For more information, see Documentation/explanation.txt (in
+	For more information, see Documentation/explanation.rst (in
 	particular, the "THE PROGRAM ORDER RELATION: po AND po-loc"
 	and "A WARNING" sections).
=20


