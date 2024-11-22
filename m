Received: from cornsilk.yew.relay.mailchannels.net (cornsilk.yew.relay.mailchannels.net [23.83.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037579C0
	for <rcu@vger.kernel.org>; Fri, 22 Nov 2024 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732284452; cv=pass; b=tDV3d8oEvpd/TJ2YgDAfBEqckwtUWdozLJI1tVMMg8vi7xlp2dL0qldV2RZUeu+gbYFOl+kmbOad4A32AU5Wgn9RDSuvhtbqUuEP7OWOGpqiGaYiAAJoy1qnqHqdkt03t/d/n/FSQMkw4ti0zr9UkmEkLWkXpPpKeeqvGguNrTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732284452; c=relaxed/simple;
	bh=zXZVhUhg6UMftYuU/yfEsyfdQ6I3CUmNscYeG0Epq8E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fOdiamKWDX2p8KPIJGFRw1DN1DAZIsCM6JYs5YXRTmfZ8l8VQy7/bzGplZ2mNeox1uT6rA8bAM2A2LPmDhsBeszlRPiH6OFnLTvK7vxzKfI5R5pcZA/qqR38yLGxYtrDHg2RcujpeZg35KW7g8ApVFsuoJDQLaH9T+O0kVGnImU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=FZEFe8Yq; arc=pass smtp.client-ip=23.83.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="FZEFe8Yq"
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2BAF9242E2
	for <rcu@vger.kernel.org>; Fri, 22 Nov 2024 09:35:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (trex-8.trex.outbound.svc.cluster.local [100.122.110.163])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BA50B23A3E
	for <rcu@vger.kernel.org>; Fri, 22 Nov 2024 09:35:30 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1732268130; a=rsa-sha256;
	cv=none;
	b=AhzPR+QBjyStXI4TyBXoepTmvMK/t2ih9d5DbZ3N8mMtbkBZKqRPfXAnGZGNHwBHyazNCW
	Z5FFet5a1V6Tfnk5uFWfV1xiAdey+IpXg53YmIZGY7LGeO05EANNlW7I7qaGdxbXpcRM2A
	riWGIl8XyNWNmuZiwRRUdMHC+/wF5VRwWJ8nut6a+rN7q3cTCHmIUJGBvTDwbdOzgLuvzM
	a95h143Pt/3TXXL/Q2cvuFvu1hlippKeOqndRrpbk5iaQ2bbmlLNLR4ZEPv8IPRwFO9qR/
	misLi/+RQHe3JwVeyENxNeKYkb4EjednTseumCqspU0C7O1V9QuPif2UkjTgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1732268130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 resent-to:resent-from:resent-message-id:dkim-signature;
	bh=HZAEqfrjCbTuothITkBDCZ7mGcsd2bpnUTM5j+JGGGQ=;
	b=USHsa4RoL1CsazocZfFe3RKROSYsip367wILLk9Y3NRKlSFUOqUA0h/2uL+Lb901e1MCO/
	KHl6gK8hAnBXN/27AcwLFMuexWkKTO4U+vKhRRXm45oH90/+8Xo9T6uwSdRSRxeLN1cTHx
	RCJ5Px37HzsHPCaoBORuh/J+7q1uA9M4tWqRyzw0vlxqzeVUMFxIHs6zVnESuwWlaPk/yF
	TJuJ6uDBFxR9qInXej6BVlOQKCI9RVVXMn0wMF74KLMHrXSJAVUH2sXhL25QsEy8jBaQJa
	+30V0aorAZep1eOlRrK/FK8odfEqV3qhL+otPIjSGhhv7MFA2SI2EO2VB4uYtg==
ARC-Authentication-Results: i=1;
	rspamd-868968d99d-87psv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=johansen@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Abaft-Shade: 51bb1d3d1035705e_1732268130966_2247031815
X-MC-Loop-Signature: 1732268130966:3630377397
X-MC-Ingress-Time: 1732268130966
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.122.110.163 (trex/7.0.2);
	Fri, 22 Nov 2024 09:35:30 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4Xvqhf46hmz60
	for <rcu@vger.kernel.org>; Fri, 22 Nov 2024 01:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1732268130;
	bh=HZAEqfrjCbTuothITkBDCZ7mGcsd2bpnUTM5j+JGGGQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=FZEFe8Yq759Eu5rpcR/O1/VwzqKTj3iM0I16yJSwwqI0G8VjII7cnoWMyCjI5IC2G
	 mduXH2sXTyTF6ECZ+njrlhZkPBNyViXICSngN4xm49u7fRf1zTRX9puG1ePSVcQQdr
	 C0qxCRMZgg8DGUWs0G3erf6aIToAHPoMIhrASBhjKqDma0aSW7108nXKirTKxoz4OR
	 vv6e8ACGKwutQDgumUrp/6V23mklNnBDyAxrcTVaEbJvDn6iFYJKjbyfmOisigYw7F
	 17JjJH1uc6ncqb8U5j4h4DWkVNHIGYh/eZDKqg8xoKVrvLq1X/MOu83VCpvYbFxt+k
	 5x3nezK7O0Ryg==
Received: from johansen (uid 1000)
	(envelope-from johansen@templeofstupid.com)
	id e0020
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Fri, 22 Nov 2024 01:35:28 -0800
Resent-From: Krister Johansen <johansen@templeofstupid.com>
Resent-Date: Fri, 22 Nov 2024 01:35:28 -0800
Resent-Message-ID: <20241122093528.GC7186@templeofstupid.com>
Resent-To: rcu@vger.kernel.org
Date: Fri, 22 Nov 2024 00:46:22 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	stable@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	David Reaver <me@davidreaver.com>
Subject: [PATCH stable 5.15/5.10 0/2] rcu-tasks: Idle tasks on offline CPUs
 are in quiescent states
Message-ID: <cover.1732237776.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Paul, Neeraj, and Stable Team:
I've run into a case with rcu_tasks_postscan where the warning introduced as
part of 46aa886c4("rcu-tasks: Fix IPI failure handling in
trc_wait_for_one_reader") is getting triggered when trc_wait_for_one_reader
sends an IPI to a CPU that is offline.  This is occurring on a platform that has
hotplug slots available but not populated.  I don't believe the bug is caused by
this change, but I do think that Paul's commit that confines the postscan
operation to just the active CPUs would help prevent this from happening.

Would the RCU maintainers be amenable to having this patch backported to the
5.10 and 5.15 branches as well?  I've attached cherry-picks of the relevant
commits to minimize the additional work needed.

Thanks,

-K

Paul E. McKenney (1):
  rcu-tasks: Idle tasks on offline CPUs are in quiescent states

 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1

