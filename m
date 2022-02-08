Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F71C433EF
	for <rcu@archiver.kernel.org>; Tue,  8 Feb 2022 05:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbiBHFrG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Feb 2022 00:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiBHFrF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Feb 2022 00:47:05 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BEEC0401EA
        for <rcu@vger.kernel.org>; Mon,  7 Feb 2022 21:47:03 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id d10so49030248eje.10
        for <rcu@vger.kernel.org>; Mon, 07 Feb 2022 21:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9XKxIIpT2t2nZ0KKm8eAvonTnPWqXXz6sYvY98ijfT0=;
        b=ltJ8MHlzD623a1jNvewPYVr4IRM9RFk/Q+UmJ85fvmL7p3tyW40eZyzj9b1JNouhph
         VMPRTqJ8Mj2phY66GLfgeGgA8Xukt7IMOHHcivo3vFQe56omAEGhpZ8VUjveZt5C2jkA
         F4v8ZZxzIlvQCkqV9FR7+xRn81KGXKeoxL5p1Mm1D+cqMj1MtuDI+OYMNyHBgD6X4KXg
         hcY8O3ZgdcHNvS28D9G7thEpFqdavYSgZ5bgz6sdFZ6sVvgePjLmYgLS2XRKBrXJfWKq
         rxEOfaPFqrCva6Q6UmxiM5yNBN611YTE4/1py9BWaCWutNwTinedaxE9+B8WhTVNucfs
         XRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9XKxIIpT2t2nZ0KKm8eAvonTnPWqXXz6sYvY98ijfT0=;
        b=3KzPlgYtjEtGWbIxBMLf5SI94ahX+oqdMRxOIaLBAWLbrhN00xbhzGIjEMqju+B3Hn
         0GL3SWBN7Y1tyUVs1B2Oj6/iwAOejBmm/hsk6ADH1t7jVM5ERe7EPRdk7Oj50ejpcwjY
         UNcVUh6b2bYUi8lZvzHedbdrW6j8QI9JQSuKD0J3y49s47D1s8688TS9Inpa8vXARP3s
         sJ4YaND61OzgqI99BPRsn/yuH6GIM15fTYyOc1wzDPwUaiOLklEcHW1CK8QWZBmWSb4A
         sk6GVxw05oj2uj9ZKHNMZaXbzQ1kt1dWf+1mkRRVmecu9914pWjm7PFXEcdnO8WpiQmF
         VA3A==
X-Gm-Message-State: AOAM531lnFAYkl75iRVJoj3LOK5t8g6sXklMOR7klQxOm3IW4ZB5kybV
        VeOp5xKDwN3KkTNnH83uZvgLNnGbBhweQlo3B8X6+kh0VD4jMw==
X-Google-Smtp-Source: ABdhPJxeoesIQZpZHa5JqtGnEIG43Rf1JaqNiDWLaxQYRgHEexAgFbNCsvEZjqCDSeJcx+La2twl8O4azvFPeNy88QA=
X-Received: by 2002:a17:907:2da0:: with SMTP id gt32mr2200927ejc.545.1644299222205;
 Mon, 07 Feb 2022 21:47:02 -0800 (PST)
MIME-Version: 1.0
References: <565038d7-7374-1005-31bf-df2f051845ff@molgen.mpg.de> <20220207175139.GD4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220207175139.GD4285@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 8 Feb 2022 13:46:50 +0800
Message-ID: <CAABZP2y10vv+fUWO+NWY=ckAX-cOkCPfQ1jsoSA=i2PzeFMkUg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_rcutorture=E2=80=99s_init_segfaults_in_ppc64le_VM?=
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, rcu <rcu@vger.kernel.org>, w@1wt.eu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Dear Paul

I am also very interested in the topic.
The Open source lab of Oregon State University has lent me a 8 core
power ppc64el VM for 3 months, I guess I can try reproducing this bug
in the Virtual Machine by executing qemu in non hardware accelerated
mode (using -no-kvm argument).
I am currently doing research on
https://lore.kernel.org/rcu/20220201175023.GW4285@paulmck-ThinkPad-P17-Gen-1/T/#mc7e5f8ec99e3794bec1e38fbbb130e71172e4759,
I think I can give a preliminary short report on that previous topic
tomorrow. And I am very interested in doing a search on the new topic
the day after tomorrow.

Thank you both for providing me an opportunity to improve myself ;-)

Thanks again
Zhouyi

On Tue, Feb 8, 2022 at 12:10 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Feb 07, 2022 at 05:44:47PM +0100, Paul Menzel wrote:
> > Dear Linux folks,
> >
> >
> > On the POWER8 server IBM S822LC running Ubuntu 21.10, building Linux
> > 5.17-rc2+ with rcutorture tests
> >
> >     $ tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
> >
> > the built init
> >
> >     $ file tools/testing/selftests/rcutorture/initrd/init
> >     tools/testing/selftests/rcutorture/initrd/init: ELF 64-bit LSB
> > executable, 64-bit PowerPC or cisco 7500, version 1 (SYSV), statically
> > linked, BuildID[sha1]=0ded0e45649184a296f30d611f7a03cc51ecb616, for
> > GNU/Linux 3.10.0, stripped
> >
> > segfaults in QEMU. From one of the log files
> >
> >
> > /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.02.01-21.52.37-torture/results-rcutorture/TREE03/console.log
> >
> >     [    1.119803][    T1] Run /init as init process
> >     [    1.122011][    T1] init[1]: segfault (11) at f0656d90 nip 10000a18
> > lr 0 code 1 in init[10000000+d0000]
> >     [    1.124863][    T1] init[1]: code: 2c2903e7 f9210030 4081ff84
> > 4bffff58 00000000 01000000 00000580 3c40100f
> >     [    1.128823][    T1] init[1]: code: 38427c00 7c290b78 782106e4
> > 38000000 <f821ff81> 7c0803a6 f8010000 e9028010
> >
> > Executing the init, which just seems to be an endless loop, from userspace
> > work:
> >
> >     $ strace ./tools/testing/selftests/rcutorture/initrd/init
> >     execve("./tools/testing/selftests/rcutorture/initrd/init",
> > ["./tools/testing/selftests/rcutor"...], 0x7ffffdb9e860 /* 31 vars */) = 0
> >     brk(NULL)                               = 0x1001d940000
> >     brk(0x1001d940b98)                      = 0x1001d940b98
> >     set_tid_address(0x1001d9400d0)          = 2890832
> >     set_robust_list(0x1001d9400e0, 24)      = 0
> >     uname({sysname="Linux",
> > nodename="flughafenberlinbrandenburgwillybrandt.molgen.mpg.de", ...}) = 0
> >     prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024,
> > rlim_max=RLIM64_INFINITY}) = 0
> >     readlink("/proc/self/exe", "/dev/shm/linux/tools/testing/sel"..., 4096)
> > = 61
> >     getrandom("\xf1\x30\x4c\x9e\x82\x8d\x26\xd7", 8, GRND_NONBLOCK) = 8
> >     brk(0x1001d970b98)                      = 0x1001d970b98
> >     brk(0x1001d980000)                      = 0x1001d980000
> >     mprotect(0x100e0000, 65536, PROT_READ)  = 0
> >     clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=1, tv_nsec=0},
> > 0x7ffffb22c8a8) = 0
> >     clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=1, tv_nsec=0},
> > 0x7ffffb22c8a8) = 0
> >     clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=1, tv_nsec=0}, ^C{tv_sec=0,
> > tv_nsec=872674044}) = ? ERESTART_RESTARTBLOCK (Interrupted by signal)
> >     strace: Process 2890832 detached
>
> Huh.  In PowerPC, is there some difference between system calls
> executed in initrd and those same system calls executed in userspace?
>
> And just to make sure, the above strace was from exactly the same
> binary "init" file that is included in initrd, correct?
>
> Adding Willy Tarreau for his thoughts.
>
>                                                         Thanx, Paul
>
> > Any ideas, what `mkinitrd.sh` [2] should do differently?
> >
> > ```
> > cat > init.c << '___EOF___'
> > #ifndef NOLIBC
> > #include <unistd.h>
> > #include <sys/time.h>
> > #endif
> >
> > volatile unsigned long delaycount;
> >
> > int main(int argc, int argv[])
> > {
> >       int i;
> >       struct timeval tv;
> >       struct timeval tvb;
> >
> >       for (;;) {
> >               sleep(1);
> >               /* Need some userspace time. */
> >               if (gettimeofday(&tvb, NULL))
> >                       continue;
> >               do {
> >                       for (i = 0; i < 1000 * 100; i++)
> >                               delaycount = i * i;
> >                       if (gettimeofday(&tv, NULL))
> >                               break;
> >                       tv.tv_sec -= tvb.tv_sec;
> >                       if (tv.tv_sec > 1)
> >                               break;
> >                       tv.tv_usec += tv.tv_sec * 1000 * 1000;
> >                       tv.tv_usec -= tvb.tv_usec;
> >               } while (tv.tv_usec < 1000);
> >       }
> >       return 0;
> > }
> > ___EOF___
> >
> > # build using nolibc on supported archs (smaller executable) and fall
> > # back to regular glibc on other ones.
> > if echo -e "#if __x86_64__||__i386__||__i486__||__i586__||__i686__" \
> >            "||__ARM_EABI__||__aarch64__\nyes\n#endif" \
> >    | ${CROSS_COMPILE}gcc -E -nostdlib -xc - \
> >    | grep -q '^yes'; then
> >       # architecture supported by nolibc
> >         ${CROSS_COMPILE}gcc -fno-asynchronous-unwind-tables -fno-ident \
> >               -nostdlib -include ../../../../include/nolibc/nolibc.h \
> >               -s -static -Os -o init init.c -lgcc
> > else
> >       ${CROSS_COMPILE}gcc -s -static -Os -o init init.c
> > fi
> > ```
> >
> >
> > Kind regards,
> >
> > Paul
> >
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/rcutorture/doc/initrd.txt
> > [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
