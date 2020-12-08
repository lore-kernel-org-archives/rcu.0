Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18EBC2BB9A
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 10:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B51B23A9D
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 10:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgLHKd1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 05:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgLHKd1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 05:33:27 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DFAC0613D6;
        Tue,  8 Dec 2020 02:32:40 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id n14so16392313iom.10;
        Tue, 08 Dec 2020 02:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fggqU2VJFoa1II5jbP6EKkjrj00ye/I/oSOoKfJ2EyU=;
        b=O8rvR0nEMju8fwgTseNAya4tLTsmY8JIxe2kvK8ZjCZnaUvqoPQWp1v/Ip7r/qYmKw
         mB6Ar+UbLyCE7WYSvfvpcdBfFhy0142H1pRhmsltO3NKuA3qIqFRQ/D7E5fAc/xLrNag
         UMqYIH1T9OVlk/necqAIgHZgwM3jnydPPkh7xIuTHpwOHRk3FOnCSoNU724omhLcYAaL
         PBdK6Bl6h1jbwbPft5Hf9T1MyFEFxjfqWRgA2DLquwpVLMD1OJKNgxzMOOJkSWwpY3e4
         aJQATLlRgQkn6c8YCGd+0jrWsO3/lGNKtgZiJIdS3q/P2/4RdS4paEZrWSKZN4d9It0c
         6Xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fggqU2VJFoa1II5jbP6EKkjrj00ye/I/oSOoKfJ2EyU=;
        b=X8US2SsVpNmgbSwIZyIQ3dr+O5OkFqyl9M/nTj8NOSLZGB0Z///gu354GN4O57npQT
         yeF2j/Tq5z9e2oF1/91CpjzNYb8H+fqGZSPHgIG+mWvqdiUoeP+32sVx3H2ylxl/tUf6
         LYOmgKZRRXmKEmrlvarHG90QRMJixe4bDNzDbqygQM36sNhr6Yx+iMPwAkU2yXF2Xwbe
         tin368vT25/KbichcYbc8v3pYgxjYcjCFDpVpotwzDeOcXc2JUmpGUpVT/MwEeRnvmw+
         9X1NScpBhVR+MC9j/cnGhwaNwI38P0V01Ebx57EjI+KFRjNEyNFeyHyxARer3yfxeYfO
         RqpQ==
X-Gm-Message-State: AOAM530l4DFoFHyGuQzeefkAYqk+bWFBxQp4unhPk6x9/5fKKP/6DMdI
        VgVVCAw03tlOB96Ik5ZeY38=
X-Google-Smtp-Source: ABdhPJxgfXPu7/UAjd0GvabW4jd0LdfX9Almzwr0CBLxZ0VituRn9Tb3oAo2bHZtB4fY83OScYF5qw==
X-Received: by 2002:a5e:8e0d:: with SMTP id a13mr13928796ion.1.1607423560329;
        Tue, 08 Dec 2020 02:32:40 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v22sm9890695ila.84.2020.12.08.02.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 02:32:38 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id EC84D27C0054;
        Tue,  8 Dec 2020 05:32:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 08 Dec 2020 05:32:36 -0500
X-ME-Sender: <xms:RFbPX6p5M_nKO4Q-wim7jwZr2B2sd5LuFRjd-2mOYA7knGoHIOEeaA>
    <xme:RFbPX41_OiMKuKLevKWpHKPILq5eV7HJo9RLUU2SI0AHK38cuAlRBAqJMSu7Fi7Rm
    uIQhhmeLaC4b2ALaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejiedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepieejhfelvddtgeduhfffueegteevleeugfekvefhueduuedugfevvefhtedvuedv
    necukfhppeduieejrddvvddtrddvrdduvdeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:RFbPXxBGV5JyVVWTEE8AodyCDKxxw0SMRJmdu49A_bvmF7E6aktlsw>
    <xmx:RFbPX4eyoRiECXhuTK_BPVRlLB3oDA1rrspB6WM14kNGWv821Av5aQ>
    <xmx:RFbPX-g4Sgd916HI7ouO9onF34rKvtCeWQJV1NTGQr-hWGIdv1Ciqg>
    <xmx:RFbPX4cKd6DrxFecHl9ER_Pm0jACRWzfa_zM30c495pMm47Il9gATb9_SiI>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1D3FC24005B;
        Tue,  8 Dec 2020 05:32:36 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC lockdep 0/4] Fixes and self testcases for wait context detection
Date:   Tue,  8 Dec 2020 18:31:08 +0800
Message-Id: <20201208103112.2838119-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Peter,

Recently I looked into the wait context check feature and found some
places could use fixes, besides a suite of test cases is also added to
verify these fixes and future development.

Note: I'm not 100% sure all the expected results of the test cases are
correct, please do have a look at the the comment of patch #4 in case I
miss something subtle.

Suggestion and comments are welcome!

Regards,
Boqun


Boqun Feng (4):
  lockdep/selftest: Make HARDIRQ context threaded
  lockdep: Allow wait context checking with empty ->held_locks
  rcu/lockdep: Annotate the rcu_callback_map with proper wait contexts
  lockdep/selftest: Add wait context selftests

 kernel/locking/lockdep.c |   6 +-
 kernel/rcu/update.c      |   8 +-
 lib/locking-selftest.c   | 233 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+), 3 deletions(-)

-- 
2.29.2

