Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA813199234;
	Fri, 11 Oct 2024 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668352; cv=none; b=A+2AcAlftXlS7JAezocZ0kkpiNlIAbreRXEl8+2EVsGJCPhA4uHWPAMLZiTsFDcUEf37uN6G1cWH93BvgXq5w0s1CoLTFrLHH9nTiGlvtIa+cBS6i9RxBn4KjGKeBGEzY/A5Art5nzppVt7U4pt+w4w6gD2ZqwYmIs7u4XbJ7GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668352; c=relaxed/simple;
	bh=l2iFzEisCe9BnUPcYMgvs7xBLciJk1BGFnxZefE5tuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+rpZApLrpYHEVXrBrHBy9ujjI1Jr1a+JOsrSkyn0fpqVhVGHqHraNtPh0oAnG9KIEgJW8Lo4DZ04fFCEdAc+6H/BCEatJ05k23+cKV5FqgV+/Ji3Ejeq6Ttm8k0Xvv0y91Tlw1sNl5X5oqvo9WeCe7LNPXT7fqesvlUKELeBdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTks7TOR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTks7TOR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5B8C4CEC3;
	Fri, 11 Oct 2024 17:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728668352;
	bh=l2iFzEisCe9BnUPcYMgvs7xBLciJk1BGFnxZefE5tuE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rTks7TORLjEovbZm2khWddbwn6SZZz2C2y8U3HMCtPmZMaRchJLqhKW6Zwa+k6ZSJ
	 3yhcxmwRBSQtMoP4DeYzEYuK3PFo/Qv6BdpxGjKKp76Ds7QNagz5KhRML5D+7DYBrB
	 8MzoAEWZJPbXNX9J8flYil/h7Pgy57h5WCGR/2gX84CeXYPJWW86kuvgl60g4EU5dW
	 EGKM4LYBK+95GxBam0a/MduPzpQL/UX5j957WK3iYRudtMN5lBqONm3hpfPQP1Xkpl
	 SI6BQUUE8zSfiwZtzfHsHPL+KVFM/M2a4YktLi5SfL88BxoACiiE0Y1vZJ/bTBk+Qv
	 eBIw/+7Z+D0tg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 10BB2CE0BB1; Fri, 11 Oct 2024 10:39:11 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:39:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v2 rcu 0/13] SRCU-lite changes for v6.13
Message-ID: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>

Hello!

This v2 series adds support and testing for srcu_read_lock_lite()
and srcu_read_unlock_lite(), which avoid smp_mb(), but add a couple of
synchronize_rcu() calls to the grace-period processing and may only be
used where RCU is watching.

1.	Rename srcu_might_be_idle() to srcu_should_expedite().

2.	Introduce srcu_gp_is_expedited() helper function.

3.	Renaming in preparation for additional reader flavor.

4.	Bit manipulation changes for additional reader flavor.

5.	Standardize srcu_data pointers to "sdp" and similar.

6.	Add srcu_read_lock_lite() and srcu_read_unlock_lite().

7.	Allow inlining of __srcu_read_{,un}lock_lite().

8.	Expand RCUTORTURE_RDR_MASK_[12] to eight bits.

9.	Add reader_flavor parameter for SRCU readers.

10.	Add srcu_read_lock_lite() support to rcutorture.reader_flavor.

11.	Add light-weight SRCU scenario.

12.	Add srcu_read_lock_lite() support using "srcu-lite".

13.	Improve srcu_read_lock_lite() kernel-doc comment.

Changes since v1:

o	Apply reviewed-by tag.

o	Link to performance data.

o	Add commit improving kernel-doc comment.

o	Pull out into separate branch to avoid dependency on an otherwise
	unrelated refscale commit.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt              |    4 
 b/Documentation/admin-guide/kernel-parameters.txt            |    8 
 b/include/linux/srcu.h                                       |   21 -
 b/include/linux/srcutree.h                                   |    2 
 b/kernel/rcu/rcutorture.c                                    |   28 -
 b/kernel/rcu/refscale.c                                      |   51 ++
 b/kernel/rcu/srcutree.c                                      |   16 
 b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST      |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L      |   10 
 b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot |    3 
 b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10      |    2 
 include/linux/srcu.h                                         |   89 +++-
 include/linux/srcutree.h                                     |   44 ++
 kernel/rcu/rcutorture.c                                      |   37 +
 kernel/rcu/srcutree.c                                        |  207 ++++++-----
 16 files changed, 363 insertions(+), 161 deletions(-)
