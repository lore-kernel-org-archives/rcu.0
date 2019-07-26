Return-Path: <SRS0=Ypbo=VX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D7CC7618F
	for <rcu@archiver.kernel.org>; Fri, 26 Jul 2019 18:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B788B22BEF
	for <rcu@archiver.kernel.org>; Fri, 26 Jul 2019 18:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564166761;
	bh=UDI9Bbnnoge0VcIU6QtA0BxlynvsdhJ504xMLxnQ0lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uslsClk0NZxn/SAv+M1C07Zw34A1/kEDnTznc88qJ7t5gwYB+UdBlWSMCOIAO40xS
	 xh1vkvbSZekYb2wNMMpOH0YpQK3Yo4rfxffdMn4Ws7/8P1wRGiyyRbZghm53NTleZx
	 tXzdp7vdSCPiLNd0l07g/gwaxpHdqv/xGPihpyH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388171AbfGZSqB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:46:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbfGZSqB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 26 Jul 2019 14:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6k2fcA3COAyy5vPlXHWvzx6/OAwBW+H3PjDlnoLqWhA=; b=g+JMpHj/ChKfClQTlS+hhtm3x
        C2FidsuyQX750/ajA7UZTuM6bvBvTWVs+90ukN6qnPFUYrcSH+unM10KZWzPmWoPwXYAe2Jaz+FJv
        Q36+mfAIr02/fSFMnVfiNjXShhLcB7IU32UaTWqZoNUllcH8z1BUu8BetcQleY/Pw5AD7+afDYvha
        rxwJ+Z2XN6gkJenQCX8Mdmu5fo0ibTaHLkhovfhP0vFy/0x428eKTGKivxJrkHOaXWlT/y7votwfR
        +S7Z5XaX/9Nc20xboBsn+4HI/W8IfVQCwT06y7mtvFONnRoBBurjsF65aENVdIfnxB2wxDtQt3at/
        y1JnycREw==;
Received: from [179.95.31.157] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr5E4-0006vW-3X; Fri, 26 Jul 2019 18:45:56 +0000
Date:   Fri, 26 Jul 2019 15:45:50 -0300
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
Message-ID: <20190726154550.5eeae294@coco.lan>
In-Reply-To: <20190726175527.GD146401@google.com>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
        <8444797277eea7be474f40625bb190775a9cee33.1564145354.git.mchehab+samsung@kernel.org>
        <20190726162002.GA146401@google.com>
        <20190726140028.38abb5fa@coco.lan>
        <20190726175527.GD146401@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Em Fri, 26 Jul 2019 13:55:27 -0400
Joel Fernandes <joel@joelfernandes.org> escreveu:

> On Fri, Jul 26, 2019 at 02:00:28PM -0300, Mauro Carvalho Chehab wrote:
> > Hi Joel,
> > 
> > Em Fri, 26 Jul 2019 12:20:02 -0400
> > Joel Fernandes <joel@joelfernandes.org> escreveu:
> >   
> > > On Fri, Jul 26, 2019 at 09:51:35AM -0300, Mauro Carvalho Chehab wrote:  
> > > > There are 4 RCU articles that are written on html format.
> > > > 

> > > Could you list what were the "some broken things" that you had to manually
> > > fix to make reviewing easier?  
> > 
> > There are a couple of things.
> > 
> > At least the pandoc's version I used here has a bug: its conversion 
> > from html to ReST on those files only start after a <body> tag - or 
> > when the first quiz table starts. I only discovered that adding a
> > <body> at the beginning of the file solve this book at the last
> > conversions.
> > 
> > So, for most html->ReST conversions, I manually converted the first
> > part of the document, basically stripping html paragraph tags and
> > by replacing highlights by the ReST syntax.
> > 
> > Also, all the quiz tables seem to assume some javascript macro or
> > css style that would be hiding the answer part until the mouse moves
> > to it. Such macro/css was not there at the kernel tree. So, the quiz
> > answers have the same color as the background, making them invisible.
> > Even if we had such macro/css, this is not portable for pdf/LaTeX output
> > (and I'm not sure if this would work with ePub).
> > 
> > So, I ended by manually doing the table conversion.
> > 
> > Finally, I double-checked if the conversions ended ok, addressing any
> > issues that might have heppened.
> > 
> > So, after both automatic conversion and manual fixes, I opened both the 
> > html files produced by Sphinx and the original ones and compared them
> > line per line (except for the indexes, as Sphinx produces them 
> > automatically), in order to see if all information from the original 
> > files will be there on a format close to what we have on other ReST
> > files, fixing any pending issues if any.  
> 
> Thanks, I am in the process of going through these docs today and will let
> you know anything I find. It would be nice to include the above challenges in
> the changelog as well.

Ok, will add on a next spin - or if you prefer to pick via your tree - feel
free to add them.

> Some reason 'make htmldocs' needed me to install a whole bunch of
> dependencies this time around.

Yes, you need Sphinx, plus some LaTeX stuff - not only for PDF but
also due to some math expressions found on some books.

Just installing Sphinx + its dependencies is enough for this specific
book.

> By the way, that tools/memory-model/Documentation/explanation.txt is a useful
> little document. Well not really little with over 1000 lines ;-). But it
> would certainly benefit from ReST's / htmldocs ability to jump to labels and
> search, etc since it is so long..

tools/*/Documentation is currently out of the current docs build system.

Maybe if you pass SPHINXDIRS=../tools/memory-model/Documentation/ it
could allow you to build something out there.

Btw, did a quick hack here, just for testing:

	$ ln -sf ../tools/memory-model/Documentation/ Documentation/tools
	$ cp tools/memory-model/Documentation/explanation.txt tools/memory-model/Documentation/explanation.rst

Sphinx tried to build explanation.txt:

/devel/v4l/docs_temp/Documentation/tools/explanation.rst:116: WARNING: Unexpected indentation.
/devel/v4l/docs_temp/Documentation/tools/explanation.rst:118: WARNING: Block quote ends without a blank line; unexpected unindent.
/devel/v4l/docs_temp/Documentation/tools/explanation.rst:122: WARNING: Unexpected indentation.
/devel/v4l/docs_temp/Documentation/tools/explanation.rst:127: WARNING: Unexpected indentation.
/devel/v4l/docs_temp/Documentation/tools/explanation.rst:128: WARNING: Block quote ends without a blank line; unexpected unindent.
/devel/v4l/docs_temp/Documentation/tools/explanation.rst:228: WARNING: Unexpected indentation.
...

So, it shouldn't be too hard to add it, but some adjustments will
be needed, specially at the code blocks.

Btw, if you want to play with it, the enclosing patch should give you
a good start.

As there aren't many files there, I suspect that converting them to
ReST should not be hard.

Thanks,
Mauro


[PATCH RFC] tools/memory-model: add it to the Documentation body

Add the cheatsheet file to the Documentation body.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 0a564f3c336e..03ff920ac1cb 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -36,6 +36,7 @@ trying to get it to work optimally on a given system.
 
    admin-guide/index
    kbuild/index
+   tools/index
 
 Firmware-related documentation
 ------------------------------
diff --git a/Documentation/tools/memory-model b/Documentation/tools/memory-model
new file mode 120000
index 000000000000..020ed38ce302
--- /dev/null
+++ b/Documentation/tools/memory-model
@@ -0,0 +1 @@
+../../tools/memory-model/Documentation/
\ No newline at end of file
diff --git a/tools/memory-model/Documentation/cheatsheet.rst b/tools/memory-model/Documentation/cheatsheet.rst
new file mode 100644
index 000000000000..35f8749b8a53
--- /dev/null
+++ b/tools/memory-model/Documentation/cheatsheet.rst
@@ -0,0 +1,36 @@
+===========
+Cheat Sheet
+===========
+
+::
+
+				    Prior Operation     Subsequent Operation
+				    ---------------  ---------------------------
+				 C  Self  R  W  RMW  Self  R  W  DR  DW  RMW  SV
+				--  ----  -  -  ---  ----  -  -  --  --  ---  --
+
+  Store, e.g., WRITE_ONCE()            Y                                       Y
+  Load, e.g., READ_ONCE()              Y                          Y   Y        Y
+  Unsuccessful RMW operation           Y                          Y   Y        Y
+  rcu_dereference()                    Y                          Y   Y        Y
+  Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
+  Successful *_release()         C        Y  Y    Y     W                      Y
+  smp_rmb()                               Y       R        Y      Y        R
+  smp_wmb()                                  Y    W           Y       Y    W
+  smp_mb() & synchronize_rcu()  CP        Y  Y    Y        Y  Y   Y   Y    Y
+  Successful full non-void RMW  CP     Y  Y  Y    Y     Y  Y  Y   Y   Y    Y   Y
+  smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
+  smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
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
diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
deleted file mode 100644
index 33ba98d72b16..000000000000
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-                                  Prior Operation     Subsequent Operation
-                                  ---------------  ---------------------------
-                               C  Self  R  W  RMW  Self  R  W  DR  DW  RMW  SV
-                              --  ----  -  -  ---  ----  -  -  --  --  ---  --
-
-Store, e.g., WRITE_ONCE()            Y                                       Y
-Load, e.g., READ_ONCE()              Y                          Y   Y        Y
-Unsuccessful RMW operation           Y                          Y   Y        Y
-rcu_dereference()                    Y                          Y   Y        Y
-Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
-Successful *_release()         C        Y  Y    Y     W                      Y
-smp_rmb()                               Y       R        Y      Y        R
-smp_wmb()                                  Y    W           Y       Y    W
-smp_mb() & synchronize_rcu()  CP        Y  Y    Y        Y  Y   Y   Y    Y
-Successful full non-void RMW  CP     Y  Y  Y    Y     Y  Y  Y   Y   Y    Y   Y
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
diff --git a/tools/memory-model/Documentation/index.rst b/tools/memory-model/Documentation/index.rst
new file mode 100644
index 000000000000..23caee7a96cc
--- /dev/null
+++ b/tools/memory-model/Documentation/index.rst
@@ -0,0 +1,17 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========
+Linux Tools
+===========
+
+.. toctree::
+   :maxdepth: 1
+
+   cheatsheet
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`

