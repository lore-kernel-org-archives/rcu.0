Return-Path: <SRS0=j702=DH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49206C4727C
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 22:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0375720709
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 22:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbgI3WZg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Sep 2020 18:25:36 -0400
Received: from smtprelay0125.hostedemail.com ([216.40.44.125]:35730 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731067AbgI3WZd (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 30 Sep 2020 18:25:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 56D1B18224519;
        Wed, 30 Sep 2020 22:25:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: watch95_3a0f65f27196
X-Filterd-Recvd-Size: 5748
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Sep 2020 22:25:29 +0000 (UTC)
Message-ID: <aefe941251d5d58062d06099afb58dea1d1d4e17.camel@perches.com>
Subject: Re: [RFC PATCH next-20200930] treewide: Convert macro and uses of
 __section(foo) to __section("foo")
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Date:   Wed, 30 Sep 2020 15:25:28 -0700
In-Reply-To: <CAKwvOd=P+j0RaQfHsXPfB0EL3oRgAu8Q0+spUOn_v-p2+3=3pw@mail.gmail.com>
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
         <20200929192549.501516-1-ndesaulniers@google.com>
         <CA+icZUVgfnVQ1=zjUGhGKnJAs9g3Q06sWN3ffNdrfZMZLCEkbA@mail.gmail.com>
         <133589afbe999347454dfcc46ae782897bf9e3a2.camel@perches.com>
         <46f69161e60b802488ba8c8f3f8bbf922aa3b49b.camel@perches.com>
         <CAKwvOdkhyvTpY6pHT+CLSsBFuKRWsXucjbwN_tyJAsryZXvG1A@mail.gmail.com>
         <417ffa3fd3fba5d4a481db6a0b0c9b48cbbb17c4.camel@perches.com>
         <CAKwvOd=P+j0RaQfHsXPfB0EL3oRgAu8Q0+spUOn_v-p2+3=3pw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 2020-09-30 at 15:20 -0700, Nick Desaulniers wrote:
> On Wed, Sep 30, 2020 at 3:06 PM Joe Perches <joe@perches.com> wrote:
> > On Wed, 2020-09-30 at 14:40 -0700, Nick Desaulniers wrote:
> > > On Wed, Sep 30, 2020 at 12:16 PM Joe Perches <joe@perches.com> wrote:
> > > > Use a more generic form for __section that requires quotes to avoid
> > > > complications with clang and gcc differences.
> > > > 
> > > > Remove the quote operator # from compiler_attributes.h __section macro.
> > > > 
> > > > Convert all unquoted __section(foo) uses to quoted __section("foo").
> > > > Also convert __attribute__((section("foo"))) uses to __section("foo")
> > > > even if the __attribute__ has multiple list entry forms.
> > > > 
> > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > > ---
> > > > 
> > > > This is the current output from the script against next-20200930
> > > > attached in this link:
> > > > 
> > > > https://lore.kernel.org/lkml/0e582a7f5144a33f465978d97701f9b3dcc377f3.camel@perches.com/
> > > > 
> > > > It might be useful to run the script immediately before
> > > > the next -rc1.
> > > 
> > > $ ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- make CC=clang -j71
> > > powernv_defconfig
> > > $ ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- make CC=clang -j71
> > > ...
> > > arch/powerpc/boot/main.c:193:44: error: expected ';' after top level declarator
> > > static char cmdline[BOOT_COMMAND_LINE_SIZE]
> > 
> > The script does not convert files in
> > 
> >         scripts/
> >         tools/
> >         uapi/
> >         and include/linux/compiler_attributes.h
> > 
> > It otherwise assumes that any __attribute__((__section__
> > use should be converted to __section.
> > 
> > If this ppc file is the only file outside of the
> > listed exclusions, I can either exclude it directly
> > or add compiler.h to it.
> > 
> > You have a preference?
> 
> If compiler_types.h which includes compiler_attributes.h is being
> implicitly including by Kbuild add `-include` flags to most
> translation units in the kernel, it would be nice to be able to use it
> everywhere.  I consider open coded __attribute__'s a portability bug.
> So including the header in arch/powerpc/boot/*.c would be my
> preference.
> 
> > Perhaps these are also possible files that need exclusions:
> > 
> > ./arch/x86/boot/video.h:#define __videocard struct card_info __section(".videocards") __attribute__((used))
> > ./arch/x86/boot/compressed/pgtable_64.c:unsigned long *trampoline_32bit __section(".data");
> > ./arch/x86/boot/tty.c:static void __section(".inittext") serial_putchar(int ch)
> > ./arch/x86/boot/tty.c:static void __section(".inittext") bios_putchar(int ch)
> > ./arch/x86/boot/tty.c:void __section(".inittext") putchar(int ch)
> > ./arch/x86/boot/tty.c:void __section(".inittext") puts(const char *str)
> > ./arch/s390/boot/startup.c:static struct diag210 _diag210_tmp_dma __section(".dma.data");
> > ./arch/powerpc/boot/main.c:     __section("__builtin_cmdline");
> > ./arch/powerpc/boot/ps3.c:      __section("__builtin_cmdline");
> > 
> > 
> 

no ppc cross compiler here, so can't test but maybe:
---
 arch/powerpc/boot/main.c | 2 ++
 arch/powerpc/boot/ps3.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 6a5b937a7f5c..ce6e27798f79 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -6,6 +6,8 @@
  */
 #include <stdarg.h>
 #include <stddef.h>
+#include <linux/compiler.h>
+
 #include "elf.h"
 #include "page.h"
 #include "string.h"
diff --git a/arch/powerpc/boot/ps3.c b/arch/powerpc/boot/ps3.c
index a71714b454b1..86ca9c30562a 100644
--- a/arch/powerpc/boot/ps3.c
+++ b/arch/powerpc/boot/ps3.c
@@ -8,6 +8,8 @@
 
 #include <stdarg.h>
 #include <stddef.h>
+#include <linux/compiler.h>
+
 #include "types.h"
 #include "elf.h"
 #include "string.h"



