Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD0BCA0FE2
	for <rcu@archiver.kernel.org>; Fri,  1 Sep 2023 02:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbjIAClN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 31 Aug 2023 22:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbjIAClN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 31 Aug 2023 22:41:13 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1656110C4
        for <rcu@vger.kernel.org>; Thu, 31 Aug 2023 19:41:06 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-77a62a84855so59093439f.1
        for <rcu@vger.kernel.org>; Thu, 31 Aug 2023 19:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693536065; x=1694140865; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6tUOs8hDMMZksGN7f6i5Wg/MdXXuZZQ/eBmMDOHEw4U=;
        b=KaKAPnSGfvfMeE9JSyDBeAjv7JkhPpHwxpP1fb4wxalPaK38qyjjIG1qkF6uT4iiPn
         C/NNhbFu5+4D08e8dX2AJGOZ3aYe0CuOiFoYR8dqnU7xJE3BXPGhLXUL1Rh3HLYHztbZ
         FuLTYLzVBoTX6jfMOaZPW1ye4P9TqWpQBlegw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693536065; x=1694140865;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tUOs8hDMMZksGN7f6i5Wg/MdXXuZZQ/eBmMDOHEw4U=;
        b=HLc6TebuMp2kntq7QhCTSgB4h5D94nLhj5HKzBqFGOrYIji9L2aAZUZ7osJLR+pJR+
         bP5eGJMa8InZWaNzzKGmAqKWAe4IxYdzUTEgp0ysORGJArx30Fn5tyzfUsqgWfPyaHia
         ubwEcqveUz6UkkgjIZJwyayx2j+OH27/Cm8rj5LxmkQGSdBW02ILUSLq85GCObP6O0MP
         Vw837SAEc4QFxLpPbOzXgcyjNMDxxJDpkUVoqXAY+TAjEUN37plFZJfB+lptI+tqNCpM
         29nDIHcpUiPaszooikjHhWFmh5vMvUy1aypp9J2hXYRcqyjTQn59CtF4c1NiGs/dI6Vo
         zntg==
X-Gm-Message-State: AOJu0YwG/aYnJY/CEE3pO2cRrGleJuLNef3kGucZStaOZgIoLx1bIFjO
        L3FSOB5jpDh/PryT2OOmI4rqSP7oj5TQ+kaCyPM=
X-Google-Smtp-Source: AGHT+IHE993Za+B/8lxV42y4X0hWTgiiDpAkz4AmxKSMOxpxJim5ey9l7gyWltDjMwVKPs5DBA5ODg==
X-Received: by 2002:a05:6e02:1186:b0:349:326:e2bd with SMTP id y6-20020a056e02118600b003490326e2bdmr1243322ili.24.1693536064950;
        Thu, 31 Aug 2023 19:41:04 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id gm16-20020a0566382b9000b0042b3e04510asm742688jab.98.2023.08.31.19.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 19:41:04 -0700 (PDT)
Date:   Fri, 1 Sep 2023 02:41:03 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     paulmck@vger.kernel.org
Subject: [BUG] Boost failure on stable kernel 6.5.y-rc1
Message-ID: <20230901024103.GA3750199@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

I got a boost failure that looks like the following. The Reader pipe counts
look good to me but there seem to be boost failures.

FWIW, I have seen this occasionally on older kernels but it was not at all
consistently reproducible. I am archiving it here for future reference:

BUG: TREE03 FAILURE, 0 instances
[ 1523.216753] rcu-torture: !!! 
[ 1523.225344] WARNING: CPU: 5 PID: 170 at kernel/rcu/rcutorture.c:2227 rcu_torture_stats_print+0x5b2/0x620
[ 1523.365730] Call Trace:
[ 1538.579852] rcu-torture: !!! Reader Pipe:  3676261572 201726 0 0 0 0 0 0 0 0 0
[ 1554.053752] rcu-torture: !!! Reader Pipe:  3714202738 203792 0 0 0 0 0 0 0 0 0
[ 1569.304750] rcu-torture: !!! Reader Pipe:  3750940990 205374 0 0 0 0 0 0 0 0 0
[ 1587.205665] rcu-torture: !!! Reader Pipe:  3783052619 207952 0 0 0 0 0 0 0 0 0
[ 1602.581730] rcu-torture: !!! Reader Pipe:  3815601996 209733 0 0 0 0 0 0 0 0 0
[ 1617.935231] rcu-torture: !!! Reader Pipe:  3851086565 211846 0 0 0 0 0 0 0 0 0
[ 1633.300072] rcu-torture: !!! Reader Pipe:  3903324168 213499 0 0 0 0 0 0 0 0 0

Full torture test directory on this failure is at:
http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.5.y/2/artifact/tools/testing/selftests/rcutorture/res/2023.08.31-21.44.10/TREE03/

thanks,

 - Joel

