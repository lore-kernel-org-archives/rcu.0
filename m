Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F74EC67871
	for <rcu@archiver.kernel.org>; Wed, 11 Jan 2023 09:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbjAKJFq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 Jan 2023 04:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbjAKJE5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 Jan 2023 04:04:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE1B140FB;
        Wed, 11 Jan 2023 01:03:16 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673427757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NdAF7zwaAIgx1nns+ekhQw7lkO0ao3fpQZq9T7cyisQ=;
        b=nW4lBkbe0G3VGzhleCOD8KoELkTbP4MJMiwslw5wPvgBeEEmn5aF4QD9Gc+Tbwg63IjH2h
        yr/NJB5Dz4P46zRYZfgzyfJJ5L0ZLPq8o26+qKQlGmw4Dyz4PJtII5NfLptGAIHWEcrUE2
        lDuWExr+gYABoTr38kyzcqz+a3ItMSfLveMAP2+5Dow+2A1fDUMdCLU0tFKT+EhV+KHRcm
        kDZ41shZL8Sr+wBYW3K3ZSHBMtKR5adcqaF/bVGZiKeP81NZM9dXDI7JELCV4jqgQozMSQ
        ujIcmPPK4b6g75FNenov7Oc3CoQjSLCnaefN4pKjjrAJbUq1zjzttjmtGttRXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673427757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NdAF7zwaAIgx1nns+ekhQw7lkO0ao3fpQZq9T7cyisQ=;
        b=gAvvbx4tX/Jg4O327/LL4sctFvjdYXQ/HN77RsqxpXr9n61ei77oPm5cLEMVWQyFOMctwM
        6mNT4A6wDlxDiBDw==
To:     Frederic Weisbecker <frederic@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     fweisbec@gmail.com, mingo@kernel.org, paulmck@kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] mark access to tick_do_timer_cpu with
 READ_ONCE/WRITE_ONCE
In-Reply-To: <Y7wN0TKU1jDyTZs5@lothringen>
References: <20221219052128.18190-1-zhouzhouyi@gmail.com>
 <Y7wN0TKU1jDyTZs5@lothringen>
Date:   Wed, 11 Jan 2023 10:02:37 +0100
Message-ID: <87tu0xiguq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jan 09 2023 at 13:51, Frederic Weisbecker wrote:
> On Mon, Dec 19, 2022 at 01:21:28PM +0800, Zhouyi Zhou wrote:
>> fix above bug by marking access to tick_do_timer_cpu with READ_ONCE/WRITE_ONCE
>
> This has been discussed before with passion:
>
> http://archive.lwn.net:8080/linux-kernel/1C65422C-FFA4-4651-893B-300FAF9C49DE@lca.pw/T/
>
> To me data_race() would be more appropriate but that would need a changelog with
> proper analysis of the tick_do_timer_cpu state machine.

Proper analysis and comments in the code are required independent of
READ/WRITE_ONCE() or data_race().

Thanks,

        tglx
